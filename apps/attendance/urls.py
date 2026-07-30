from django.urls import path
from . import views

urlpatterns = [
    # Pase de asistencia por horario
    path('pase/<int:horario_pk>/', views.pase_asistencia, name='pase_asistencia'),

    # Reportes (admin)
    path('reporte/', views.reporte_asistencia, name='reporte_asistencia'),

    # Exportar CSV (admin)
    path('exportar/', views.exportar_csv, name='exportar_csv'),
]
