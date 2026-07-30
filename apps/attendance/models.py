"""
apps/attendance/models.py

Modelo de Asistencia: registra la presencia/ausencia de un alumno
en un horario específico, en una fecha dada.
"""

from django.db import models
from django.contrib.auth.models import User
from apps.courses.models import Alumno, Horario


class Asistencia(models.Model):
    """
    Registro de asistencia por alumno, horario y fecha.
    El Profesor queda registrado automáticamente desde la sesión activa.
    """
    ESTADO_CHOICES = [
        ('P', 'Presente'),
        ('A', 'Ausente'),
        ('J', 'Justificado'),   # Estado opcional para mayor flexibilidad
    ]

    alumno = models.ForeignKey(
        Alumno,
        on_delete=models.CASCADE,
        related_name='asistencias',
        verbose_name='Alumno'
    )
    horario = models.ForeignKey(
        Horario,
        on_delete=models.CASCADE,
        related_name='asistencias',
        verbose_name='Horario'
    )
    fecha = models.DateField(verbose_name='Fecha de la clase')
    estado = models.CharField(
        max_length=1,
        choices=ESTADO_CHOICES,
        default='A',
        verbose_name='Estado'
    )
    profesor_registro = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        related_name='asistencias_registradas',
        verbose_name='Registrado por'
    )
    fecha_registro = models.DateTimeField(
        auto_now_add=True,
        verbose_name='Fecha/hora de registro'
    )

    class Meta:
        verbose_name = 'Asistencia'
        verbose_name_plural = 'Asistencias'
        ordering = ['-fecha', 'alumno__apellido']
        # Cada alumno tiene un único registro por horario+fecha
        unique_together = ('alumno', 'horario', 'fecha')

    def __str__(self):
        return (
            f"{self.alumno.nombre_completo()} | "
            f"{self.horario} | "
            f"{self.fecha} | "
            f"{self.get_estado_display()}"
        )
