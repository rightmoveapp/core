from django.contrib.auth.models import User, Group
from rest_framework.viewsets import ModelViewSet
from api.serializers import UserSerializer, GroupSerializer, QuestionSerializer
from api.models import Question


class UserViewSet(ModelViewSet):
  # API endpoint that allows users to be views or edited
  queryset = User.objects.all().order_by('-date_joined')
  serializer_class = UserSerializer

class GroupViewSet(ModelViewSet):
  queryset = Group.objects.all()
  serializer_class = GroupSerializer

class QuestionViewSet(ModelViewSet):
  queryset = Question.objects.all()
  serializer_class = QuestionSerializer