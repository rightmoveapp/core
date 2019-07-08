from django.contrib import admin
from api.models import Question, Content, Category, Subcategory, Choice, UserAttribute, Job, JobAttribute, PersistantSession,UserBasicProfile,UserAnswer

admin.site.register(Question)
admin.site.register(Content)
admin.site.register(Category)
admin.site.register(Subcategory)
admin.site.register(Choice)
admin.site.register(UserAttribute)
admin.site.register(Job)
admin.site.register(JobAttribute)
admin.site.register(PersistantSession)
admin.site.register(UserBasicProfile)
admin.site.register(UserAnswer)
