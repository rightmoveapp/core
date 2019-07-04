from django.contrib import admin
from django.urls import path, include, re_path
from api import views

urlpatterns = [
    # path('', include(router.urls)),
    path('api-auth/',include('rest_framework.urls', namespace='rest_framework')),
    path('v1/login', views.login),
    path('v1/account', views.user_profile),
    path('admin/', admin.site.urls),
]
