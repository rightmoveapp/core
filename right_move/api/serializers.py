from django.contrib.auth.models import User, Group
from rest_framework.serializers import HyperlinkedModelSerializer as HMS
from api.models import Question, Content



class UserSerializer(HMS):
  class Meta:
    model = User
    fields = ('url', 'username', 'email', 'groups')

class GroupSerializer(HMS):
  class Meta:
    model = Group
    fields = ('url','name')

class QuestionSerializer(HMS):
  class Meta:
    model = Question
    fields = ('body','category','subcategory')

class ContentSerializer(HMS):
  class Meta:
    model = Content
    fields = ('created_at', 'updated_at','page','description','copy')