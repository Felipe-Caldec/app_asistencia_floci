"""
apps/attendance/forms.py
"""

from django import forms
from apps.courses.models import Curso, Horario


class FiltroReporteForm(forms.Form):
    """Filtros para el reporte en pantalla."""
    curso = forms.ModelChoiceField(
        queryset=Curso.objects.filter(activo=True).order_by('nombre'),
        required=False,
        label='Curso',
        empty_label='— Todos los cursos —'
    )
    horario = forms.ModelChoiceField(
        queryset=Horario.objects.filter(activo=True).select_related('curso'),
        required=False,
        label='Horario',
        empty_label='— Todos los horarios —'
    )
    fecha = forms.DateField(
        required=False,
        label='Fecha',
        widget=forms.DateInput(attrs={'type': 'date'})
    )


class FiltroCSVForm(forms.Form):
    """Filtros para la exportación CSV — todos los campos son obligatorios."""
    fecha_inicio = forms.DateField(
        label='Fecha inicio',
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    fecha_fin = forms.DateField(
        label='Fecha fin',
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    curso = forms.ModelChoiceField(
        queryset=Curso.objects.filter(activo=True).order_by('nombre'),
        label='Curso',
        empty_label='— Selecciona un curso —'
    )
    horario = forms.ModelChoiceField(
        queryset=Horario.objects.filter(activo=True).select_related('curso'),
        label='Horario',
        empty_label='— Selecciona un horario —'
    )

    def clean(self):
        cleaned_data = super().clean()
        fecha_inicio = cleaned_data.get('fecha_inicio')
        fecha_fin = cleaned_data.get('fecha_fin')
        if fecha_inicio and fecha_fin and fecha_inicio > fecha_fin:
            raise forms.ValidationError('La fecha de inicio no puede ser posterior a la fecha fin.')
        return cleaned_data
