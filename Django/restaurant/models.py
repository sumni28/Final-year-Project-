from math import fabs
from django.db import models
from django.contrib.auth import get_user_model


class Restaurant(models.Model):
    # location, opening_time, closing_time, restaurant_menu, restaurant_email
    restaurantName = models.CharField(max_length=80)
    location = models.CharField(max_length=80)
    openingTime = models.CharField(max_length=100)
    closingTime = models.CharField(max_length=100)
    # restaurantMenu=models.CharField()
    restaurantEmail = models.CharField(max_length=200)
    restaurantPhonenumber = models.CharField(max_length=20)
    cusine=models.CharField(max_length=200,default="Multi Cusine")
    minimumOrder = models.IntegerField()
    restaurantInfo = models.CharField(max_length=250)
    password=models.CharField(max_length=100)
    restaurantImage=models.ImageField(upload_to ='images/')
    sponsored=models.BooleanField(default=False)
    def __str__(self):
        return self.restaurantName




class RestaurantReview(models.Model):
    # reviewId, restaurant_rating, restaurant_comment, restaurantId*,customerId*
    restaurantRating = models.IntegerField(default=0)
    RestaurantLiked=models.BooleanField(default=False)
    restaurantId = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    userId = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)

    def __str__(self):
        return self.userId.username+" "+str(self.RestaurantLiked)

class RestaurantComment(models.Model):
    restaurant_id=models.ForeignKey(Restaurant,on_delete=models.CASCADE)
    user_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    comment=models.CharField(max_length=240)
