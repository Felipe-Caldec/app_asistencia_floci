from django.contrib import admin
from .models import ProfesorProfile

@admin.register(ProfesorProfile)
class ProfesorProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'telefono', 'departamento']
    search_fields = ['user__username', 'user__first_name', 'user__last_name']
