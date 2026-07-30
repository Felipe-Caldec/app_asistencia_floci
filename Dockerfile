FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libpq-dev gcc && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Recolectar estáticos al construir la imagen
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["gunicorn", "asistencia_project.wsgi:application", "--workers", "3", "--bind", "0.0.0.0:8000", "--timeout", "120"]