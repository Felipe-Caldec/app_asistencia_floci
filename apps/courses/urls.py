from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('cursos/<int:pk>/', views.detalle_curso, name='detalle_curso'),
    path('cursos/crear/', views.crear_curso, name='crear_curso'),
    path('cursos/<int:pk>/editar/', views.editar_curso, name='editar_curso'),
    path('horarios/crear/', views.crear_horario, name='crear_horario'),
    path('horarios/<int:pk>/editar/', views.editar_horario, name='editar_horario'),
    path('alumnos/', views.lista_alumnos, name='lista_alumnos'),
    path('alumnos/crear/', views.crear_alumno, name='crear_alumno'),
    path('alumnos/<int:pk>/editar/', views.editar_alumno, name='editar_alumno'),
    path('alumnos/excel/', views.exportar_alumnos_excel, name='exportar_alumnos_excel'),
    path('alumnos/carga-csv/', views.carga_csv_alumnos, name='carga_csv_alumnos'),
    path('asignar-alumno/', views.asignar_alumno, name='asignar_alumno'),
    path('asignar-profesor/', views.asignar_profesor_horario, name='asignar_profesor_horario'),
    # API endpoint para filtrado dinámico de horarios por curso
    path('api/horarios/<int:curso_pk>/', views.horarios_por_curso, name='horarios_por_curso'),
]
