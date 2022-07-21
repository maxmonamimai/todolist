
from rest_framework import serializers
from .models import *

class TodoList_Serializer(serializers.ModelSerializer):
    class Meta:
        model = TodoList
        fields = ('id', 'title', 'detail')

