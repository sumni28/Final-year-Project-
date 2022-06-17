from django.db import models
from restaurant.models import Restaurant
from LoginSignUp.models import CustomerUser

from django.contrib.auth import get_user_model

class Food(models.Model):
    foodName = models.CharField(max_length=200)
    foodCategory = models.CharField(max_length=200)
    foodDiscountcode = models.CharField(max_length=30)
    foodImage = models.ImageField(upload_to='images/')
    foodDescription = models.CharField(max_length=200)
    price=models.IntegerField()
    restaurant_id = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    date=models.DateField()
    def __str__(self):
            return self.foodName

class FoodReview(models.Model):
    # reviewId, restaurant_rating, restaurant_comment, restaurantId*,customerId*
    rating = models.IntegerField(default=0)
    liked=models.BooleanField(default=False)
    food_id = models.ForeignKey(Food, on_delete=models.CASCADE)
    userId = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)

    def __str__(self):
        return self.userId.username+" "+str(self.liked)

class FoodComment(models.Model):
    food_id=models.ForeignKey(Food,on_delete=models.CASCADE)
    user_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    comment=models.CharField(max_length=240)
