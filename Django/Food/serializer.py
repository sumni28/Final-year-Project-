from rest_framework import serializers

from LoginSignUp.serializers import UserSerializer
from .models import Food, FoodComment, FoodReview




class FoodPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model = Food
        fields = '__all__'

class FoodGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Food
        fields = '__all__'
        depth=1


class FoodReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = FoodReview
        fields ="__all__"

class AddCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = FoodComment
        fields ="__all__"

class GetCommentSerializer(serializers.ModelSerializer):
    user_id=UserSerializer()
    class Meta:
        model = FoodComment
        fields ="__all__"