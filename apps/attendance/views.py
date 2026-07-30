"""
apps/attendance/views.py

Vistas para:
  1. Pase de asistencia (por horario y fecha)
  2. Reportes visuales en pantalla (solo admin)
  3. Exportación CSV (solo admin)
"""

import csv
from datetime import date, datetime

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.http import HttpResponse
from django.db.models import Count, Q

from apps.courses.models import Horario, Alumno, Curso, AsignacionAlumno
from .models import Asistencia
from .forms import FiltroReporteForm, FiltroCSVForm


def es_admin(user):
    return user.is_superuser


# ─────────────────────────────────────────────────────────────────────────────
# PASE DE ASISTENCIA
# ─────────────────────────────────────────────────────────────────────────────

@login_required
def pase_asistencia(request, horario_pk):
    """
    Vista principal de toma de asistencia.
    Muestra la lista de alumnos inscritos en el curso del horario dado,
    con checkboxes para marcar Presente.

    GET  → Muestra el formulario con el estado actual del día.
    POST → Guarda/actualiza los registros de asistencia con CSRF protegido.
    """
    horario = get_object_or_404(Horario, pk=horario_pk, activo=True)

    # Verificar acceso: admin o profesor asignado al horario
    if not request.user.is_superuser and horario.profesor != request.user:
        messages.error(request, 'No tienes permiso para registrar asistencia en este horario.')
        return redirect('dashboard')

    fecha_hoy = date.today()

    # Obtener alumnos asignados a este curso
    asignaciones = AsignacionAlumno.objects.filter(
        curso=horario.curso
    ).select_related('alumno').order_by('alumno__apellido', 'alumno__nombre')

    if not asignaciones.exists():
        messages.warning(request, 'Este curso no tiene alumnos asignados aún.')
        return redirect('detalle_curso', pk=horario.curso.pk)

    # Recuperar registros existentes para hoy (para prellenar el formulario)
    registros_existentes = {
        a.alumno_id: a.estado
        for a in Asistencia.objects.filter(
            horario=horario, fecha=fecha_hoy
        )
    }

    if request.method == 'POST':
        # Procesar el formulario: para cada alumno, leer el estado enviado
        for asignacion in asignaciones:
            alumno = asignacion.alumno
            # El checkbox envía 'P' si marcado; si no aparece, es Ausente ('A')
            estado = request.POST.get(f'estado_{alumno.pk}', 'A')
            # Validar que el estado sea uno válido
            if estado not in ('P', 'A', 'J'):
                estado = 'A'

            Asistencia.objects.update_or_create(
                alumno=alumno,
                horario=horario,
                fecha=fecha_hoy,
                defaults={
                    'estado': estado,
                    'profesor_registro': request.user,
                }
            )

        messages.success(request, f'Asistencia del {fecha_hoy.strftime("%d/%m/%Y")} guardada correctamente.')
        return redirect('pase_asistencia', horario_pk=horario.pk)

    # Construir lista de alumnos con su estado actual para el template
    alumnos_con_estado = []
    for asignacion in asignaciones:
        alumno = asignacion.alumno
        alumnos_con_estado.append({
            'alumno': alumno,
            'estado': registros_existentes.get(alumno.pk, 'A'),
        })

    return render(request, 'attendance/pase_asistencia.html', {
        'horario': horario,
        'fecha_hoy': fecha_hoy,
        'alumnos_con_estado': alumnos_con_estado,
        'profesor': request.user,
    })


# ─────────────────────────────────────────────────────────────────────────────
# REPORTES EN PANTALLA (solo admin)
# ─────────────────────────────────────────────────────────────────────────────

@login_required
@user_passes_test(es_admin, login_url='/')
def reporte_asistencia(request):
    """
    Reporte visual filtrable por Curso, Horario y Fecha.
    Calcula el porcentaje de presentes por día.
    """
    form = FiltroReporteForm(request.GET or None)
    resultados = []
    resumen = None

    if form.is_valid():
        curso = form.cleaned_data.get('curso')
        horario = form.cleaned_data.get('horario')
        fecha = form.cleaned_data.get('fecha')

        # Base queryset con los filtros seleccionados
        qs = Asistencia.objects.select_related(
            'alumno', 'horario__curso', 'horario__profesor', 'profesor_registro'
        )

        if curso:
            qs = qs.filter(horario__curso=curso)
        if horario:
            qs = qs.filter(horario=horario)
        if fecha:
            qs = qs.filter(fecha=fecha)

        qs = qs.order_by('fecha', 'alumno__apellido')
        resultados = list(qs)

        # Calcular resumen de porcentaje de presentes
        if resultados:
            total = len(resultados)
            presentes = sum(1 for r in resultados if r.estado == 'P')
            resumen = {
                'total': total,
                'presentes': presentes,
                'ausentes': total - presentes,
                'porcentaje': round((presentes / total) * 100, 1) if total > 0 else 0,
            }

    return render(request, 'attendance/reporte.html', {
        'form': form,
        'resultados': resultados,
        'resumen': resumen,
    })


# ─────────────────────────────────────────────────────────────────────────────
# EXPORTAR CSV (solo admin)
# ─────────────────────────────────────────────────────────────────────────────

@login_required
@user_passes_test(es_admin, login_url='/')
def exportar_csv(request):
    """
    Genera y descarga un archivo CSV con el historial de asistencia
    filtrado por rango de fechas, Curso y Horario.
    """
    form = FiltroCSVForm(request.GET or None)

    if request.GET and form.is_valid():
        fecha_inicio = form.cleaned_data['fecha_inicio']
        fecha_fin = form.cleaned_data['fecha_fin']
        curso = form.cleaned_data['curso']
        horario = form.cleaned_data['horario']

        # Construir queryset con los filtros obligatorios
        qs = Asistencia.objects.filter(
            fecha__gte=fecha_inicio,
            fecha__lte=fecha_fin,
            horario__curso=curso,
            horario=horario,
        ).select_related(
            'alumno', 'horario__curso', 'horario__profesor', 'profesor_registro'
        ).order_by('fecha', 'alumno__apellido', 'alumno__nombre')

        # Preparar la respuesta HTTP como archivo CSV
        nombre_archivo = (
            f"asistencia_{curso.nombre.replace(' ', '_')}_"
            f"{fecha_inicio}_{fecha_fin}.csv"
        )

        # BOM para compatibilidad con Excel en español
        response = HttpResponse(
            content_type='text/csv; charset=utf-8-sig'
        )
        response['Content-Disposition'] = f'attachment; filename="{nombre_archivo}"'

        writer = csv.writer(response)

        # Encabezado del CSV
        writer.writerow([
            'Fecha',
            'Curso',
            'Horario (Día)',
            'Hora Inicio',
            'Hora Fin',
            'Sala',
            'RUT Alumno',
            'Nombre Alumno',
            'Apellido Alumno',
            'Estado',
            'Profesor Registrador',
        ])

        # Filas de datos
        for registro in qs:
            writer.writerow([
                registro.fecha.strftime('%d/%m/%Y'),
                registro.horario.curso.nombre,
                registro.horario.get_dia_semana_display(),
                registro.horario.hora_inicio.strftime('%H:%M'),
                registro.horario.hora_fin.strftime('%H:%M'),
                registro.horario.sala or '',
                registro.alumno.rut,
                registro.alumno.nombre,
                registro.alumno.apellido,
                registro.get_estado_display(),
                registro.profesor_registro.get_full_name() if registro.profesor_registro else '',
            ])

        return response

    # GET sin filtros → mostrar formulario
    return render(request, 'attendance/exportar_csv.html', {'form': form})
