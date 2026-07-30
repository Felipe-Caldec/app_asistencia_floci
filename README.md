# Control de Asistencia — Django + PostgreSQL

Sistema modular de registro de asistencia a clases con Django 5, PostgreSQL y Tailwind CSS.

---

## Estructura del proyecto

```
asistencia/
├── manage.py
├── requirements.txt
├── asistencia_project/
│   ├── __init__.py
│   ├── settings.py          ← Configuración (BD, apps, auth)
│   ├── urls.py              ← Enrutamiento principal
│   └── wsgi.py
│
├── apps/
│   ├── users/               ← Perfiles de Profesor, gestión de usuarios
│   │   ├── models.py        → ProfesorProfile
│   │   ├── views.py         → CRUD profesores (solo admin)
│   │   ├── forms.py
│   │   ├── urls.py
│   │   └── admin.py
│   │
│   ├── courses/             ← Cursos, horarios, alumnos, asignaciones
│   │   ├── models.py        → Alumno, Curso, Horario, AsignacionAlumno
│   │   ├── views.py         → Dashboard, detalle, CRUD (admin)
│   │   ├── forms.py
│   │   ├── urls.py
│   │   └── admin.py
│   │
│   └── attendance/          ← Pase de asistencia, reportes, CSV
│       ├── models.py        → Asistencia
│       ├── views.py         → pase_asistencia, reporte, exportar_csv
│       ├── forms.py
│       ├── urls.py
│       └── admin.py
│
├── templates/
│   ├── base/
│   │   └── base.html        ← Layout base con navbar y mensajes
│   ├── users/
│   │   ├── login.html
│   │   ├── lista_profesores.html
│   │   ├── crear_profesor.html
│   │   └── editar_profesor.html
│   ├── courses/
│   │   ├── dashboard.html
│   │   ├── detalle_curso.html
│   │   ├── lista_alumnos.html
│   │   ├── form_curso.html
│   │   ├── form_horario.html
│   │   ├── form_alumno.html
│   │   ├── form_asignacion.html
│   │   └── asignar_profesor.html
│   └── attendance/
│       ├── pase_asistencia.html
│       ├── reporte.html
│       └── exportar_csv.html
│
└── static/
    └── css/                 ← Estilos personalizados (Tailwind vía CDN)
```

---

## Instalación y puesta en marcha

### 1. Crear el entorno virtual e instalar dependencias

```bash
python -m venv venv
source venv/bin/activate      # Linux/macOS
venv\Scripts\activate         # Windows

pip install -r requirements.txt
```

### 2. Crear la base de datos en PostgreSQL

```sql
CREATE DATABASE asistencia_db;
CREATE USER postgres WITH PASSWORD 'tu_password';
GRANT ALL PRIVILEGES ON DATABASE asistencia_db TO postgres;
```

### 3. Configurar variables de entorno (opcional pero recomendado)

```bash
export DB_NAME=asistencia_db
export DB_USER=postgres
export DB_PASSWORD=tu_password
export DB_HOST=localhost
export DB_PORT=5432
```

O editar directamente `asistencia_project/settings.py`.

### 4. Aplicar migraciones

```bash
python manage.py makemigrations users courses attendance
python manage.py migrate
```

### 5. Crear el superusuario (Administrador)

```bash
python manage.py createsuperuser
```

### 6. Ejecutar el servidor de desarrollo

```bash
python manage.py runserver
```

Acceder en: http://127.0.0.1:8000/

---

## Flujo de uso básico (como Administrador)

1. **Login** en `/login/` con las credenciales del superusuario.
2. **Crear cursos** desde el Dashboard → "Crear Curso" (o desde la URL `/cursos/crear/`).
3. **Crear alumnos** desde el Dashboard → "Crear Alumno".
4. **Crear horarios** desde el Dashboard → "Crear Horario" (vincula Curso + Profesor).
5. **Asignar alumnos** a cursos desde "Asignar Alumno".
6. **Crear profesores** desde el menú "Profesores" → "Nuevo Profesor".

## Flujo del Profesor

1. Login en `/login/` con sus credenciales.
2. Ve solo los cursos donde tiene horarios asignados.
3. Hace clic en un curso → ve sus horarios.
4. Hace clic en "Tomar Asistencia" → marca el estado de cada alumno → "Guardar".

---

## Modelos principales

| Modelo | App | Descripción |
|---|---|---|
| `ProfesorProfile` | users | Datos extra del profesor (1-a-1 con User) |
| `Alumno` | courses | Nombre, Apellido, RUT |
| `Curso` | courses | Asignatura o clase |
| `Horario` | courses | Bloque horario con Curso + Profesor + día/hora |
| `AsignacionAlumno` | courses | Relación Alumno ↔ Curso (muchos a muchos explícita) |
| `Asistencia` | attendance | Registro Alumno + Horario + Fecha + Estado |

## Roles y permisos

| Capacidad | Admin (Superusuario) | Profesor |
|---|:---:|:---:|
| Ver todos los cursos | ✓ | ✗ |
| Ver sus cursos asignados | ✓ | ✓ |
| Crear/editar cursos, horarios, alumnos | ✓ | ✗ |
| Asignar alumnos y profesores | ✓ | ✗ |
| Tomar asistencia | ✓ | ✓ |
| Ver reportes en pantalla | ✓ | ✗ |
| Exportar CSV | ✓ | ✗ |
