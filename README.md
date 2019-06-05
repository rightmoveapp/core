# RightMove
_intelligent career design_

## Why?
When we are looking for a new gig, it is easy to cling to the simple KPIs - money, time off, fancy office digs ets. But the understanding of how real factors play into elements like our personal fulfilment, our life trajectory, and our ability to find "flow" requires a more empirical approach. We can use science and math to help see the big picture, and determine with certainty which role is the RightMove for you. 

## Where did this come from?
This started as a spreadsheet to compare different factors between companies. Things like "Salary" and "Healthcare" needed to be weighted more than "Free Gym", so we added some basic statical z-score normalization. This expanded to using natural language questions to further weight the candidate metrics, and the idea that we could use post-hiring satisfaction surveys to train an ML model.. and the rest is history. 

## Architecture
![architecture diagram](./readme_assets/stack.png)

RightMove uses a React.js SPA while both application behavior and machine learning models all live within the Django REST framework. Data is stored in Postgresql. Training data obtained from the Linkedin API via OAUTH login is also incorporated. 

## SiteMap
![early sitemap](./readme_assets/sitemap.png)
The site map will consist of a few key user stories:
- as a user I want to be able to answer questions about me to train the model
- as a user I want to be able to answer questions about a job to see how it fits
- as a user I want to be able to view job results side by side and compare 
- as a user I want to be able to pick which stat model is used for a fit

## Roles 
- the *web app team* will handle the react application, the user authentication and the OAUTH login calls. They will handle the MVC layer transactional database ORM design. 

- the *data science team* will build the model(s) as modules with a simple API for integration into the application model layer.

- the *devops team* will containerize and deploy the application, and set up basic CI/CD.
 
