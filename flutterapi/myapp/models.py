from django.db import models

class TodoList(models.Model):
    title = models.CharField(max_length=100)
    detail = models.TextField(null=True, blank=True)

    def __str__ (self):
        return f'{self.title}'

