from rest_framework import serializers

from Blog.models import Blog
from restaurant.serializer import RestaurantSerializer

class BlogPOSTSerialier(serializers.ModelSerializer):
    class Meta:
        model = Blog
        fields ="__all__"

class BlogGETSerializer(serializers.ModelSerializer):
    restaurant=RestaurantSerializer()
    class Meta:
        model=Blog
        fields="__all__"