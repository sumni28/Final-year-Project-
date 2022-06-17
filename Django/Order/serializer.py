from dataclasses import fields
from rest_framework import serializers
from Food.serializer import FoodGetSerializer
from LoginSignUp.serializers import UserSerializer
from drink.serializer import DrinkGETSerializer
from Order.models import Order, OrderItem, UserCart
from restaurant.serializer import RestaurantSerializer


class UserCartPostSerializer(serializers.ModelSerializer):# For patch and post request
    class Meta:
        model = UserCart
        fields = '__all__'

class UserCartGetSerializer(serializers.ModelSerializer):# For get request
    foodId=FoodGetSerializer()
    drinkId=DrinkGETSerializer()
    class Meta:
        model = UserCart
        fields = '__all__'

class OrderPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model=Order
        fields='__all__'

class OrderGETSerializer(serializers.ModelSerializer):
    restaurant=RestaurantSerializer()
    user=UserSerializer()
    class Meta:
        model=Order
        fields='__all__'

class OrderItemPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model=OrderItem
        fields='__all__'

class OrderItemGETSerializer(serializers.ModelSerializer):
    food=FoodGetSerializer()
    drink=DrinkGETSerializer()
    class Meta:
        model=OrderItem
        fields='__all__'
       
        