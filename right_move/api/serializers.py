from django.contrib.auth.models import User, Group
from rest_framework.serializers import HyperlinkedModelSerializer as HMS
from api.models import Question, Content, Category, Subcategory, Choice, User_Attribute, Job, Job_Attribute, PeristantSession



class UserSerializer(HMS):
  class Meta:
    model = User
    fields = ('url', 'username', 'email', 'groups')

class GroupSerializer(HMS):
  class Meta:
    model = Group
    fields = ('url','name')

class CategorySerializer(HMS):
  class Meta:
    model = Category
    fields = ('created_at', 'updated_at','category_name')

class SubcategorySerializer(HMS):
  class Meta:
    model = Category
    fields = ('created_at', 'updated_at','subcategory_name')

class QuestionSerializer(HMS):
  class Meta:
    model = Question
    fields = ('created_at', 'updated_at','body','category_id','subcategory_id')

class ContentSerializer(HMS):
  class Meta:
    model = Content
    fields = ('created_at', 'updated_at','page','description','copy')