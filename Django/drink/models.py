from django.db import models
from LoginSignUp.models import CustomerUser
from restaurant.models import Restaurant

from django.contrib.auth import get_user_model

class Drink(models.Model):
    # drinkId,drink_name, drink_category, drink_description, drink_discountcode, drink_picture, restaurantId*
    drinkName = models.CharField(max_length=100)
    drinkCategory = models.CharField(max_length=100)
    drinkDescription = models.CharField(max_length=10000)
    drinkDiscountcode = models.CharField(max_length=50)
    drinkImage = models.ImageField(upload_to='images/')
    price=models.IntegerField()
    restaurant_id = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    date=models.DateField()
    def __str__(self):
            return self.drinkName


class DrinkReview(models.Model):
    # reviewId, restaurant_rating, restaurant_comment, restaurantId*,customerId*
    rating = models.IntegerField(default=0)
    liked=models.BooleanField(default=False)
    drink_id = models.ForeignKey(Drink, on_delete=models.CASCADE)
    userId = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)

    def __str__(self):
        return self.userId.username+" "+str(self.liked)

class DrinkComment(models.Model):
    drink_id=models.ForeignKey(Drink,on_delete=models.CASCADE)
    user_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    comment=models.CharField(max_length=240)
