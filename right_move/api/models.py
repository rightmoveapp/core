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
  category = models.ForeignKey(Category, on_delete=models.PROTECT)
  subcategory = models.ForeignKey(Subcategory, on_delete=models.PROTECT)

class Choice(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  choice = models.TextField()
  question= models.ForeignKey(Question, on_delete=models.CASCADE)

class UserBasicProfile(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  birthday = models.DateField()
  ethnicity = models.CharField(max_length=250)
  address_1 = models.CharField(max_length=250)
  address_2 = models.CharField(max_length=250)
  city = models.CharField(max_length=250)
  state = models.CharField(max_length=250)
  zipcode = models.CharField(max_length=250)
  education = models.CharField(max_length=250)
  gender = models.CharField(max_length=250)
  years_experience = models.IntegerField()
  relationship_status = models.CharField(max_length=250)
  num_dependents = models.IntegerField()
  sexual_orientation = models.CharField(max_length=250)
  user = models.ForeignKey(User, on_delete=models.CASCADE)

class UserAttribute(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  category = models.ForeignKey(Category, on_delete=models.PROTECT)
  subcategory = models.ForeignKey(Subcategory, on_delete=models.PROTECT)
  category_value = models.CharField(max_length=250, null=True)
  subcategory_value = models.CharField(max_length=250, null=True)
  user = models.ForeignKey(User, on_delete=models.CASCADE)

class Job(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  company_name = models.CharField(max_length=250, null=True)
  role = models.CharField(max_length=250, null=True)
  score = models.DecimalField(decimal_places=2,max_digits=3, null=True)
  is_current = models.BooleanField(default=False)
  user = models.ForeignKey(User, on_delete=models.CASCADE)

class JobAttribute(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  attribute_name = models.CharField(max_length=250)
  attribute_value = models.CharField(max_length=250)
  job = models.ForeignKey(Job, on_delete=models.CASCADE)

class Content(models.Model):
  created_at = models.DateTimeField(auto_now_add = True)
  updated_at = models.DateTimeField(auto_now = True)
  page = models.CharField(max_length=250)
  description = models.CharField(max_length=250)
  copy = models.TextField()

class PersistantSession(models.Model):
  user= models.ForeignKey(User, unique=True, blank=False, on_delete=models.CASCADE)
  token = models.CharField(max_length=1000)
  updated_at = models.DateTimeField(auto_now = True)