"""
urls.py — Enrutamiento principal del proyecto
"""

from django.contrib import admin
from django.urls import path, include
from django.contrib.auth import views as auth_views

urlpatterns = [
    # Panel de administración nativo de Django
    path('admin/', admin.site.urls),

    # Autenticación (login / logout)
    path('login/', auth_views.LoginView.as_view(template_name='users/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),

    # Módulos de la aplicación
    path('', include('apps.courses.urls')),        # Dashboard y cursos
    path('attendance/', include('apps.attendance.urls')),  # Asistencia y reportes
    path('users/', include('apps.users.urls')),    # Gestión de usuarios (admin)
]
