from django.db import models
from django.contrib.auth.models import AbstractUser


class CustomerUser(AbstractUser):
    customerName = models.CharField(max_length=80,null=True, blank=True,default="")
    customerLocation = models.CharField(max_length=80,null=True,blank=True, default="")
