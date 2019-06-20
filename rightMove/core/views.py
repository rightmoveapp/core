from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse


def survey(request):
    return HttpResponse("This is the survey page")