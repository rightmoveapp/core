from django.contrib import admin
from django.urls import path, include, re_path
from rest_framework import routers
from api import views

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups',views.GroupViewSet)
router.register(r'questions',views.QuestionViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/',include('rest_framework.urls', namespace='rest_framework')),
    path('v1/login', views.login),
    re_path(r'^v1/me', views.me),
    path('/v1/account/', views.userProfile),
    path('admin/', admin.site.urls),
    

]
