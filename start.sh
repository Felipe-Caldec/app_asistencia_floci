#!/bin/bash
echo "Aplicando migraciones..."
python manage.py migrate --noinput

echo "Creando superusuario si no existe..."
python manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'CambiarPassword123!')
    print('Superusuario creado')
else:
    print('Superusuario ya existe')
"

echo "Iniciando Gunicorn..."
gunicorn asistencia_project.wsgi:application --workers 3 --bind 0.0.0.0:8000 --timeout 120