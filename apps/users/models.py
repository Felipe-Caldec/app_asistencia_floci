"""
apps/users/models.py

Extiende el modelo User de Django para agregar datos de perfil del profesor.
"""

from django.db import models
from django.contrib.auth.models import User


class ProfesorProfile(models.Model):
    """
    Perfil adicional para usuarios con rol de Profesor.
    Vinculado 1-a-1 con el User nativo de Django.
    Los Superusuarios (is_superuser=True) actúan como Administradores
    y no requieren este perfil.
    """
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        related_name='profesor_profile',
        verbose_name='Usuario'
    )
    telefono = models.CharField(max_length=20, blank=True, verbose_name='Teléfono')
    departamento = models.CharField(max_length=100, blank=True, verbose_name='Departamento')

    class Meta:
        verbose_name = 'Perfil de Profesor'
        verbose_name_plural = 'Perfiles de Profesores'

    def __str__(self):
        return f"Perfil de {self.user.get_full_name() or self.user.username}"
