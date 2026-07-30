from django.contrib import admin
from .models import Asistencia


@admin.register(Asistencia)
class AsistenciaAdmin(admin.ModelAdmin):
    list_display = ['alumno', 'horario', 'fecha', 'estado', 'profesor_registro']
    list_filter = ['estado', 'fecha', 'horario__curso']
    search_fields = ['alumno__nombre', 'alumno__apellido', 'alumno__rut']
    date_hierarchy = 'fecha'
