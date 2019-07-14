from django.db import connection

class DataScience:
    
    def update_user_metrics(self,user_id:int)->None:
        """ executes a big scary sql function 
            that updates all the user metrics."""
        with connection.cursor() as cursor:
            cursor.execute(f"SELECT update_user_metrics({user_id})")
        ##TODO: this should return something 

    def update_job_metrics(self, job_id):
        """ executes a big scary sql function 
            that updates all the job metrics."""
        with connection.cursor() as cursor:
            cursor.execute(f"SELECT update_job_metrics({job_id})")
        ##TODO: this should return something 
        
    def do_science(self, user_id, job_id):
        """ combines both """
        self.update_user_metrics(user_id)
        self.update_job_metrics(job_id)

