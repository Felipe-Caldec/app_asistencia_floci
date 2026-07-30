"""
apps/courses/models.py
"""

from django.db import models
from django.contrib.auth.models import User
from datetime import date


class Alumno(models.Model):
    GENERO_CHOICES = [
        ('M', 'Masculino'),
        ('F', 'Femenino'),
        ('O', 'Otro'),
    ]

    nombre    = models.CharField(max_length=100, verbose_name='Nombre')
    apellido  = models.CharField(max_length=100, verbose_name='Apellido')
    rut       = models.CharField(max_length=12, unique=True, verbose_name='RUT / ID', help_text='Formato: 12345678-9')
    genero    = models.CharField(max_length=1, choices=GENERO_CHOICES, blank=True, verbose_name='Género')
    correo    = models.EmailField(blank=True, unique=True, verbose_name='Correo electrónico')
    fecha_nacimiento = models.DateField(verbose_name="Fecha Nacimiento")
    edad      = models.PositiveSmallIntegerField(null=True, blank=True, verbose_name='Edad')
    telefono  = models.CharField(max_length=20, blank=True, verbose_name='Teléfono')
    activo    = models.BooleanField(default=True, verbose_name='Activo')
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    def calcular_edad(self):
        """Calcula la edad en años completos a partir de fecha_nacimiento."""
        if not self.fecha_nacimiento:
            return None
        hoy = date.today()
        return hoy.year - self.fecha_nacimiento.year - (
            (hoy.month, hoy.day) < (self.fecha_nacimiento.month, self.fecha_nacimiento.day)
        )

    def save(self, *args, **kwargs):
        """Recalcula la edad antes de cada guardado."""
        self.edad = self.calcular_edad()
        super().save(*args, **kwargs)

    class Meta:
        verbose_name = 'Alumno'
        verbose_name_plural = 'Alumnos'
        ordering = ['apellido', 'nombre']

    def __str__(self):
        return f"{self.apellido}, {self.nombre} ({self.rut})"

    def nombre_completo(self):
        return f"{self.nombre} {self.apellido}"


class Curso(models.Model):
    nombre      = models.CharField(max_length=150, verbose_name='Nombre del Curso')
    descripcion = models.TextField(blank=True, verbose_name='Descripción')
    activo      = models.BooleanField(default=True, verbose_name='Activo')
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = 'Curso'
        verbose_name_plural = 'Cursos'
        ordering = ['nombre']

    def __str__(self):
        return self.nombre


class Horario(models.Model):
    DIAS_SEMANA = [
        ('LUN', 'Lunes'), ('MAR', 'Martes'), ('MIE', 'Miércoles'),
        ('JUE', 'Jueves'), ('VIE', 'Viernes'), ('SAB', 'Sábado'),('DOM','Domingo')
    ]

    curso      = models.ForeignKey(Curso, on_delete=models.CASCADE, related_name='horarios', verbose_name='Curso')
    profesor   = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='horarios_asignados', verbose_name='Profesor')
    dia_semana = models.CharField(max_length=3, choices=DIAS_SEMANA, verbose_name='Día de la semana')
    hora_inicio = models.TimeField(verbose_name='Hora de inicio')
    hora_fin    = models.TimeField(verbose_name='Hora de término')
    sala        = models.CharField(max_length=50, blank=True, verbose_name='Sala')
    activo      = models.BooleanField(default=True, verbose_name='Activo')

    class Meta:
        verbose_name = 'Horario'
        verbose_name_plural = 'Horarios'
        ordering = ['dia_semana', 'hora_inicio']

    def __str__(self):
        return (
            f"{self.curso.nombre} — "
            f"{self.get_dia_semana_display()} "
            f"{self.hora_inicio.strftime('%H:%M')}-{self.hora_fin.strftime('%H:%M')}"
        )

    def profesor_nombre(self):
        if self.profesor:
            return self.profesor.get_full_name() or self.profesor.username
        return 'Sin asignar'


class AsignacionAlumno(models.Model):
    alumno  = models.ForeignKey(Alumno, on_delete=models.CASCADE, related_name='asignaciones', verbose_name='Alumno')
    curso   = models.ForeignKey(Curso, on_delete=models.CASCADE, related_name='asignaciones_curso', verbose_name='Curso')
    horario = models.ForeignKey(
        'Horario',
        on_delete=models.CASCADE,
        related_name='asignaciones_horario',
        null=True, blank=True,
        verbose_name='Horario específico'
    )
    fecha_asignacion = models.DateField(auto_now_add=True)

    class Meta:
        verbose_name = 'Asignación de Alumno'
        verbose_name_plural = 'Asignaciones de Alumnos'
        unique_together = ('alumno', 'horario')

    def __str__(self):
        return f"{self.alumno} → {self.curso}"
