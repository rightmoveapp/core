## requests lets you make API calls
import requests
import os

def get_from_linkedin(auth_code:str)->dict:
  """trades the auth code for a token,
    then calls 2 APIs to get you all the good stuff"""

  #start by collecting all your API bits
  auth_token_url = "https://www.linkedin.com/oauth/v2/accessToken"
  user_basics_url = 'https://api.linkedin.com/v2/me'
  email_url = 'https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))'
  grant_type = "authorization_code"
  ## this needs to match EXACTLY with what you have listed with Linkedin
  redirect_uri = "http://localhost:3000/linkedin_auth"
  ## use envars to import these, don't keep in your repo!
  client_id = os.environ["REDSTAPLER_LINKEDIN_CLIENT_ID"]
  client_secret = os.environ["REDSTAPLER_LINKEDIN_SECRET"]
  code = auth_code

  ## make dictionary to send over to linkedin
  params = {"grant_type":grant_type,
            "redirect_uri":redirect_uri,
            "client_id":client_id,
            "client_secret":client_secret,
            "code":auth_code}

  ##Post to linkedin to receive token
  response = requests.post(auth_token_url, params)


  token = response.json()['access_token']

  access_header = {"Authorization":f"Bearer {token}"}

  ## now get the username and such
  basics = requests.get(user_basics_url, headers=access_header).json()

  ## and finally the email address
  email = requests.get(email_url,headers =access_header).json()

  ##now make a useful object and return it
  result = dict()
  result['email'] = email["elements"][0]["handle~"]["emailAddress"].lower()
  result['last_name'] = basics['localizedLastName'].lower()
  result['first_name'] = basics['localizedFirstName'].lower()

  return result