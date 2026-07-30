from django import forms
from django.contrib.auth.models import User
from .models import Curso, Horario, Alumno, AsignacionAlumno


class CursoForm(forms.ModelForm):
    class Meta:
        model = Curso
        fields = ['nombre', 'descripcion', 'activo']
        widgets = {'descripcion': forms.Textarea(attrs={'rows': 3})}


class HorarioForm(forms.ModelForm):
    class Meta:
        model = Horario
        fields = ['curso', 'profesor', 'dia_semana', 'hora_inicio', 'hora_fin', 'sala', 'activo']
        widgets = {
            'hora_inicio': forms.TimeInput(format='%H:%M', attrs={'type': 'time'}),
            'hora_fin':    forms.TimeInput(format='%H:%M', attrs={'type': 'time'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['profesor'].queryset = User.objects.filter(
            is_superuser=False, is_active=True
        ).order_by('last_name', 'first_name')


class AlumnoForm(forms.ModelForm):
    class Meta:
        model  = Alumno
        fields = ['nombre', 'apellido', 'rut', 'genero', 'correo','fecha_nacimiento', 'telefono', 'activo']


class AsignacionAlumnoForm(forms.ModelForm):
    class Meta:
        model  = AsignacionAlumno
        fields = ['alumno', 'curso', 'horario']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['alumno'].queryset  = Alumno.objects.filter(activo=True).order_by('apellido')
        self.fields['curso'].queryset   = Curso.objects.filter(activo=True).order_by('nombre')
        self.fields['horario'].queryset = Horario.objects.filter(activo=True).select_related('curso')
