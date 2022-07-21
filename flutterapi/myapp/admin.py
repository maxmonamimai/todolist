from django.contrib import admin

from myapp.models import TodoList
from .models import *

admin.site.register(TodoList)
