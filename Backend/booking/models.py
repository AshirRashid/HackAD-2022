from django.db import models

# Create your models here.
class Bookings(models.Model):
    date = models.DateField()
    net_id = models.CharField(max_length=30)
    room_num = models.CharField(max_length=30)
    start_time = models.CharField(max_length=30)
