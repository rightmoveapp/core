from django.contrib import admin
from api.models import Question, Content, Category, Subcategory, Choice, User_Attribute, Job, Job_Attribute, PeristantSession

admin.site.register(Question)
admin.site.register(Content)
admin.site.register(Category)
admin.site.register(Subcategory)
admin.site.register(Choice)
admin.site.register(User_Attribute)
admin.site.register(Job)
admin.site.register(Job_Attribute)
admin.site.register(PeristantSession)
