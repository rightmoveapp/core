from django.db import models

# Create your models here.
class Question(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  body = models.TextField()
  category = models.CharField(max_length=100)
  subcategory = models.CharField(max_length=100)