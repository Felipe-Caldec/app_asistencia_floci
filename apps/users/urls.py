from django.urls import path
from . import views

urlpatterns = [
    path('profesores/', views.lista_profesores, name='lista_profesores'),
    path('profesores/crear/', views.crear_profesor, name='crear_profesor'),
    path('profesores/<int:pk>/editar/', views.editar_profesor, name='editar_profesor'),
    path('profesores/<int:pk>/toggle/', views.toggle_profesor, name='toggle_profesor'),
    path('profesores/excel/', views.exportar_profesores_excel, name='exportar_profesores_excel'),
    path('profesores/carga-csv/', views.carga_csv_profesores, name='carga_csv_profesores'),
]
