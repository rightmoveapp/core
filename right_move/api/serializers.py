from django.contrib.auth.models import User, Group
from rest_framework.serializers import HyperlinkedModelSerializer as HMS
from api.models import Question



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