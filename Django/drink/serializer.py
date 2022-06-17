from rest_framework import serializers

from LoginSignUp.serializers import UserSerializer
from .models import Drink, DrinkComment, DrinkReview



class DrinkPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model = Drink
        fields = '__all__'

class DrinkGETSerializer(serializers.ModelSerializer):
    class Meta:
        model = Drink
        fields = '__all__'
        depth=1

class DrinkReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = DrinkReview
        fields ="__all__"

class AddCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = DrinkComment
        fields ="__all__"

class GetCommentSerializer(serializers.ModelSerializer):
    user_id=UserSerializer()
    class Meta:
        model = DrinkComment
        fields ="__all__"