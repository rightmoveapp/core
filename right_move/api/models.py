from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Category(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  category_name = models.CharField(max_length=100)
  class Meta:
        db_table = "Categories"
        verbose_name_plural = "Categories"

class Subcategory(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  subcategory_name = models.CharField(max_length=100)
  class Meta:
        db_table = "Subcategories"
        verbose_name_plural = "Subcategories"

class Question(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  body = models.TextField()
  category_id = models.ForeignKey(Category, on_delete=models.PROTECT)
  subcategory_id = models.ForeignKey(Subcategory, on_delete=models.PROTECT)

class Choice(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  choice = models.TextField()
  question_id = models.ForeignKey(Question, on_delete=models.CASCADE)

class User_Attribute(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  category_id = models.ForeignKey(Category, on_delete=models.PROTECT)
  subcategory_id = models.ForeignKey(Subcategory, on_delete=models.PROTECT)
  value = models.CharField(max_length=250)

class Job(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  company_name = models.CharField(max_length=250, null=True)
  role = models.CharField(max_length=250, null=True)
  user_id = models.ForeignKey(User, on_delete=models.CASCADE)

class Job_Attribute(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  attribute_name = models.CharField(max_length=250)
  attribute_value = models.CharField(max_length=250)
  job_id = models.ForeignKey(Job, on_delete=models.CASCADE)

class Content(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  page = models.CharField(max_length=250)
  description = models.CharField(max_length=250)
  copy = models.TextField()

class PeristantSession(models.Model):
  user_id = models.ForeignKey(User, unique=True, blank=False, on_delete=models.CASCADE)
  token = models.CharField(max_length=1000)
  updated_at = models.DateTimeField(auto_now = True)