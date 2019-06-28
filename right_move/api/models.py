from django.db import models

# Create your models here.
class Category(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  category_name = models.CharField(max_length=100)

class Subcategory(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  subcategory_name = models.CharField(max_length=100)

class Question(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  body = models.TextField()
  category = models.ForeignKey(Category)
  subcategory = models.ForeignKey(Subcategory)

class Choices(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  choice = models.TextField()
  question_id = models.ForeignKey(Subcategory)

class User_Attributes(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)

class Jobs(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  