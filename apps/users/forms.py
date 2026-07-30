"""
apps/users/forms.py
"""

from django import forms
from django.contrib.auth.models import User


class CrearProfesorForm(forms.ModelForm):
    """Formulario para crear un nuevo Profesor."""
    password1 = forms.CharField(
        label='Contraseña',
        widget=forms.PasswordInput(attrs={'class': 'input-field'})
    )
    password2 = forms.CharField(
        label='Confirmar contraseña',
        widget=forms.PasswordInput(attrs={'class': 'input-field'})
    )
    telefono = forms.CharField(max_length=20, required=False, label='Teléfono')
    departamento = forms.CharField(max_length=100, required=False, label='Departamento')

    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email']

    def clean(self):
        cleaned_data = super().clean()
        p1 = cleaned_data.get('password1')
        p2 = cleaned_data.get('password2')
        if p1 and p2 and p1 != p2:
            raise forms.ValidationError('Las contraseñas no coinciden.')
        return cleaned_data


class EditarProfesorForm(forms.ModelForm):
    """Formulario para editar un Profesor existente."""
    telefono = forms.CharField(max_length=20, required=False, label='Teléfono')
    departamento = forms.CharField(max_length=100, required=False, label='Departamento')

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email', 'is_active']
