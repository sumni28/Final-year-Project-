from asyncio.windows_events import NULL
from math import fabs
from django.db import models
from pandas import isnull
from LoginSignUp.models import CustomerUser
from restaurant.models import Restaurant
from drink.models import Drink
from Food.models import Food
from LoginSignUp.models import CustomerUser


class Order(models.Model):
    user=models.ForeignKey(CustomerUser,on_delete=models.CASCADE)
    restaurant=models.ForeignKey(Restaurant,on_delete=models.CASCADE)
    totalPrice=models.IntegerField()
    location=models.CharField(max_length=255)
    restaurantDelivered=models.BooleanField(default=False)
    userReceived=models.BooleanField(default=False)
    paymentDone=models.BooleanField(default=False)
    paymentByCash=models.BooleanField(default=True)
    forDonating=models.BooleanField(default=False)
    preOrderDate=models.DateField(null=True,blank=True)

    def __str__(self):
            return str(self.id)

class OrderItem(models.Model):
    order=models.ForeignKey(Order,on_delete=models.CASCADE)
    food=models.ForeignKey(Food,on_delete=models.CASCADE,null=True,blank=True)
    drink=models.ForeignKey(Drink,on_delete=models.CASCADE,null=True,blank=True)
    quantity=models.IntegerField()
    notes=models.CharField(max_length=255,null=True,blank=True)

    def __str__(self):
            return str(self.id)

class UserCart(models.Model):
    foodId=models.ForeignKey(Food,on_delete=models.CASCADE,null=True,blank=True)
    drinkId=models.ForeignKey(Drink,on_delete=models.CASCADE,null=True,blank=True)
    quantity=models.IntegerField()
    userId=models.ForeignKey(CustomerUser,on_delete=models.CASCADE)
    notes=models.CharField(max_length=255,null=True,blank=True)

    def __str__(self):
            return "ID: "+str(self.id)+". Quantity: "+str(self.quantity)
