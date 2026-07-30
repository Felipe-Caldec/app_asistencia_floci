from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0001_initial'),  # ← pon aquí tu última migración
    ]

    operations = [
        migrations.AddField(
            model_name='alumno',
            name='edad',
            field=models.PositiveSmallIntegerField(
                null=True, blank=True, verbose_name='Edad'
            ),
        ),
    ]