from django.contrib import admin
from .models import Alumno, Curso, Horario, AsignacionAlumno


@admin.register(Alumno)
class AlumnoAdmin(admin.ModelAdmin):
    list_display = ['apellido', 'nombre', 'rut', 'activo']
    search_fields = ['nombre', 'apellido', 'rut']
    list_filter = ['activo']


@admin.register(Curso)
class CursoAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'activo']
    search_fields = ['nombre']


@admin.register(Horario)
class HorarioAdmin(admin.ModelAdmin):
    list_display = ['curso', 'dia_semana', 'hora_inicio', 'hora_fin', 'profesor', 'sala']
    list_filter = ['dia_semana', 'curso']
    search_fields = ['curso__nombre', 'profesor__username']


@admin.register(AsignacionAlumno)
class AsignacionAlumnoAdmin(admin.ModelAdmin):
    list_display = ['alumno', 'curso', 'fecha_asignacion']
    list_filter = ['curso']
    search_fields = ['alumno__nombre', 'alumno__apellido', 'curso__nombre']
