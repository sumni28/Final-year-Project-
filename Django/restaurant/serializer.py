from rest_framework import serializers

from LoginSignUp.serializers import UserSerializer
from .models import Restaurant, RestaurantComment, RestaurantReview


class RestaurantRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = '__all__'
class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        #fields = '__all__'
        exclude = ['password']

class RestaurantLoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields =["restaurantEmail","password"]

class RestaurantReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantReview
        fields ="__all__"

class AddCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantComment
        fields ="__all__"

class GetCommentSerializer(serializers.ModelSerializer):
    user_id=UserSerializer()
    class Meta:
        model = RestaurantComment
        fields ="__all__"
