
from datetime import date
from pyexpat import model
from django.db import models
from restaurant.models import Restaurant

class Blog(models.Model):
    heading=models.CharField(max_length=244)
    description=models.CharField(max_length=255)
    restaurant=models.ForeignKey(Restaurant,on_delete=models.CASCADE)
    image=models.ImageField(upload_to='images/')
    date=models.DateField()

    def __str__(self):
        return self.heading