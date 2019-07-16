from django.contrib import admin
from django.urls import path, include, re_path
from api import views

urlpatterns = [
    # path('', include(router.urls)),
    path('v1/login', views.login),
    path('api-auth/',include('rest_framework.urls', namespace='rest_framework')),
    path('v1/account', views.user_profile),
    path('v1/usergraph', views.user_graph),
    path('v1/userquestions', views.user_attr_questions),
    path('v1/userattranswers', views.user_attr_answers),
    path('v1/jobquestions', views.job_questions),
    path('v1/userbasicanswers', views.user_basic_profile),
    path('v1/userjobanswers', views.job_answers),
    path('admin/', admin.site.urls),
]
