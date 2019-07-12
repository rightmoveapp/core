from django.db import connection

class DataScience:
    
    def update_user_metrics(self,user_id:int)->None:
        """ executes a big scary sql function 
            that updates all the user metrics."""
        with connection.cursor() as cursor:
            cursor.execute(f"SELECT update_user_metrics({user_id})")
        ##TODO: this should return something 


