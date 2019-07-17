from django.contrib.auth.models import User, Group
from rest_framework.viewsets import ModelViewSet
from api.serializers import UserSerializer, GroupSerializer, QuestionSerializer
from api.models import Question, Content, Category, Subcategory, Choice, UserAttribute, Job, JobAttribute, PersistantSession,UserBasicProfile, UserAnswer, JobQuestion, JobChoice, JobAnswer, Role, RoleSalary,QuestionMapping, ZipcodeDetail, UserAttributeWeight
from django.db.models import F
import random
import string
from datetime import datetime
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseForbidden, JsonResponse
from api.utils.login import get_from_linkedin
from api.utils.data_science import DataScience
import json


def login(request):
    """ this is the view that will take a Authorization header
    and return the app cookie token.
    we then use that token for every view we want secured via the self_authenticate function
    below."""
    auth_token = request.headers.get('Authorization',None).replace('Bearer ',"").strip()
    if auth_token is None:
        return HttpResponseBadRequest("Authorization is a required header.")

    try:
        linkedin_user = get_from_linkedin(auth_token)
    ## this isn't a real error. fix this to match however get_user_from_linkedin handles failures.
    except Exception as e:
      return HttpResponseForbidden(f'error form getlinkedin is {e}')
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
    response = dict()
    response["token"] = session.token
    response["first_name"] = authed_user.first_name
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


######end point to get the user profile################################################
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

  response["subcategories"] = list()
  user_sub_vals = user.userattribute_set.all()
  for eachsub in user_sub_vals:
    sub = dict()
    sub_id = eachsub.subcategory.pk
    sub["name"] = Subcategory.objects.get(id = sub_id).subcategory_name
    sub["value"] = eachsub.value
    response["subcategories"].append(sub)

  response["jobs"]=list()
  all_jobs = user.job_set.all()
  for eachjob in all_jobs:
    job = dict()
    job["id"]= eachjob.id
    job["company_name"] = eachjob.company_name
    job["score"] = eachjob.score
    job["salary"] = eachjob.salary
    job["is_current"] = eachjob.is_current
    role_id = eachjob.role.pk
    job["role"] = Role.objects.get(id = role_id).role_name
    # role = Role.objects.get(id=job.role).role_name
    # get_role = Role.objects.get(id = job["role"])
    # role = get_role["role_name"]
    response["jobs"].append(job)

  # response["subcategories"] = list(Subcategory.objects.all().values("subcategory_name","heuristic_value"))


  return JsonResponse(response)

################## End point to get user graph when we get d3 working #################################
# def user_graph(request):
#   response = dict()

# ##call the authenticate object to get a user object
#   try:
#     user = self_authenticate(request)
#   except ValueError as e:
#     return HttpResponseBadRequest(e)

#   response["name"] = "flare"
#   response["children"] = list()
#   categories = Category.objects.all().annotate(name=F('category_name')).values("id","name")
#   for category in categories:
#     category["children"] = list(Subcategory.objects.filter(category = category["id"]).annotate(name=F('subcategory_name')).values("name", "heuristic_value"))
#     response["children"].append(category)

#   return JsonResponse(response)

##################End point to get the user attribute questions################################

def user_attr_questions(request):
  response = dict()
##call the authenticate object to get a user object
  try:
    user = self_authenticate(request)
  except ValueError as e:
    return HttpResponseBadRequest(e)

  response["questionsAndChoices"] = list()
  questions = Question.objects.all().values('id','question_text','input_type','placeholder')
  for question in questions:
    question["choices"] = list(Choice.objects.filter(question = question["id"]).values("id", "choice_text"))
    for choice in question["choices"]:
      choice["input_type"] = question["input_type"]
    if not user.useranswer_set.filter(question = question["id"]).exists():
      response["questionsAndChoices"].append(question)

  return JsonResponse(response)


################## End point to post the user attribute answers ################################
def user_attr_answers(request):
  
##call the authenticate object to get a user object
  try:
    user = self_authenticate(request)
  except ValueError as e:
    return HttpResponseBadRequest(e)

  data = json.loads(request.body.decode('utf8'))
  
  UserAnswer.objects.create(
    question_id=data["question"],
    answer=data["answer"],
    user_id=user.id
  )
  datascience = DataScience()
  if user.job_set.all().count() <1:
    datascience.update_user_metrics(user.id)
  else:
    jobs = user.job_set.all()
    
    for job in jobs:
      
      datascience.do_science(user.id, job.id)
  return HttpResponse({"success":True})


################## End point to get the job questions ################################
def job_questions(request):
  response = dict()
#call the authenticate object to get a user object
  try:
    user = self_authenticate(request)
  except ValueError as e:
    return HttpResponseBadRequest(e)

  response["questionsAndChoices"] = list()
  questions = JobQuestion.objects.all().values('id','question_text','input_type','placeholder')
  for question in questions:
    question["choices"] = list(JobChoice.objects.filter(question = question["id"]).values("id", "choice_text"))
    for choice in question["choices"]:
      choice["input_type"] = question["input_type"]
    response["questionsAndChoices"].append(question)
  role_names = list(Role.objects.all().values("role_name"))
  response["role_names"] = role_names

  return JsonResponse(response)


################## End point to post a new job and its answers ################################
def job_answers(request):

##call the authenticate object to get a user object
  try:
    user = self_authenticate(request)
  except ValueError as e:
    return HttpResponseBadRequest(e)

  data = json.loads(request.body.decode('utf8'))
  
  if data["isCurrent"] == "yes":
    isCurrent = True
  elif data["isCurrent"] == "no":
    isCurrent = False
  job = Job.objects.create(
    company_name = data["companyName"],
    role = Role.objects.get(role_name = data["role_name"]),
    user_id=user.id,
    city = data["city"],
    zipcode = data["zipcode"],
    salary = data["salary"],
    is_current = isCurrent,
  )
  job.save()

  jobQAndAs = data["questionsAndAnswers"]
  # jobAttrs = list()
  # for pair in jobQAndAs
  #   jobAttrs.append(JobAnswer(question_id=pair[]))

  # [Category(name="God"),
  #    Category(name="Demi God"),
  #    Category(name="Mortal")]

  for key, value in jobQAndAs.items():
    
    JobAnswer.objects.create(
      question_id=key,
      answer=value,
      job_id=job.id
    )
  datascience = DataScience()
  if user.userattribute_set.all().count() > 1:
    datascience.update_job_metrics(job.id)

  return HttpResponse({"success":True})

################## End point to post a new user basic profile ################################
def user_basic_profile(request):
##call the authenticate object to get a user object
  try:
    user = self_authenticate(request)
  except ValueError as e:
    return HttpResponseBadRequest(e)

  data = json.loads(request.body.decode('utf8'))
  UserBasicProfile.objects.create(
    # question_id=data["question"],
    # answer=data["answer"],
    user_id=user.id,
    birthday=data["questionsAndAnswers"]["birthday"],
    ethnicity = data["questionsAndAnswers"]["race_ethnicity"],
    # address_1 = models.CharField(max_length=250)
    # address_2 = models.CharField(max_length=250)
    # city = models.CharField(max_length=250)
    # state = models.CharField(max_length=250)
    pronouns = data["questionsAndAnswers"]["pronouns"],
    zipcode = data["questionsAndAnswers"]["zipcode"],
    area_code = data["questionsAndAnswers"]["areacode"],
    education = data["questionsAndAnswers"]["education"],
    gender = data["questionsAndAnswers"]["gender"],
    role = Role.objects.get(role_name = data["role_name"]),
    years_experience = data["questionsAndAnswers"]["years_experience"],
    relationship_status = data["questionsAndAnswers"]["relationship_status"],
    num_dependents = data["questionsAndAnswers"]["num_dependents"],
  )

  return HttpResponse({"success":True})
