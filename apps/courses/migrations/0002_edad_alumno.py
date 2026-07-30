from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0001_initial'),  # ← ajusta al nombre de tu migración anterior
    ]

    operations = [
        migrations.RunSQL(
            sql="ALTER TABLE courses_alumno ADD COLUMN IF NOT EXISTS edad SMALLINT NULL;",
            reverse_sql="ALTER TABLE courses_alumno DROP COLUMN IF EXISTS edad;",
        ),
    ]