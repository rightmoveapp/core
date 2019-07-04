from django.contrib.auth.models import User, Group
from rest_framework.viewsets import ModelViewSet
from api.serializers import UserSerializer, GroupSerializer, QuestionSerializer
from api.models import Question, Content, Category, Subcategory, Choice, UserAttribute, Job, JobAttribute, PersistantSession,UserBasicProfile
import random
import string
from datetime import datetime
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseForbidden, JsonResponse
from api.utils.login import get_from_linkedin

def login(request):
    """ this is the view that will take a LinkedinCode header
    and return the app cookie token.
    we then use that token for every view we want secured via the self_authenticate function
    below."""
    auth_token = request.headers.get('LinkedinCode',None)
    if auth_token is None:
        return HttpResponseBadRequest("LinkedinCode is a required header.")

    try:
        linkedin_user = get_from_linkedin(auth_token)
    ## this isn't a real error. fix this to match however get_user_from_linkedin handles failures.
    except Exception as e:
        return HttpResponseForbidden(e)
    print("sucess token")
    ## look for the user and get him/her/it if exists, if not create new user
    """NOTE: get_or_create returns a tuple (USER, did_or_didnt_create,) with
        the user object and weather or not it had to create him/her/it.
        we use [0] cus we just want the user (first value of the tuple)."""
    authed_user = User.objects.get_or_create(
        first_name = linkedin_user['first_name'],
        last_name = linkedin_user['last_name'],
        email = linkedin_user['email']
    )[0]

    ## make sure if it DID have to create a user we save him/her/it
    authed_user.save()

    ## create or update session token using this crypto method
    ## https://stackoverflow.com/questions/2257441/random-string-generation-with-upper-case-letters-and-digits/23728630#23728630 
    token = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(100))

    session = PersistantSession.objects.update_or_create(
        user = authed_user,
        defaults={"token":token}

    )[0]
    session.save()

    ## respond to the request with the created token!
    response = {}
    response["token"] = session.token
    return JsonResponse(response)


## run this self_authenticate function in the very beginning
## of any view function you want to restrict to the logged-in
## user.
def self_authenticate(request):
    """ extracts a PersistantToken from a request,
        returns a user or 403 if none found."""
    AUTH = "Authorization"
    if AUTH in request.headers:
        ## clean up the token
        token = request.headers[AUTH].replace("Bearer ","").strip() ## this "Bearer <token>" format is standard auth for a token
        user = PersistantSession.objects.get(token=token).user
        return user
    else:
        raise ValueError(f"{AUTH} is required!")

def user_profile(request):
  response = dict()

##call the authenticate object to get a user object
  try:
    user = self_authenticate(request)
  except ValueError as e:
    return HttpResponseBadRequest(e)

  response["first_name"] = user.first_name
  response["last_name"] = user.last_name
  response["email"] = user.email

  response["birthday"] = user.userbasicprofile.birthday

  response["userattributes"] = list(user.userattribute_set.values('category', 'category_value'))


  response["jobs"] = list(user.job_set.values('company_name','role','score','salary','is_current'))

  return JsonResponse(response)

