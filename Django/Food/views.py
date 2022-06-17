from datetime import datetime
from restaurant.models import Restaurant
from .models import Food, FoodComment, FoodReview
from .serializer import AddCommentSerializer, FoodPOSTSerializer, FoodReviewSerializer, FoodGetSerializer, GetCommentSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

from rest_framework.decorators import api_view


class RestaurantFoodApiView(APIView):
    def get(self, request,rest_id):
        try:
            restaurant=Restaurant.objects.get(id=rest_id)
            food = Food.objects.filter(restaurant_id=restaurant)
            serializer = FoodGetSerializer(food, many=True)
            return Response(serializer.data)
        except Restaurant.DoesNotExist:
            return Response({
                "details":"Restaurant Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST)
        

    


class FoodApiView(APIView):
    def get(self, request):
        food = Food.objects.all()
        serializer = FoodGetSerializer(food, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = FoodPOSTSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class FoodDetailApiView(APIView):

    def get(self, request, id):
        try:
            food = Food.objects.get(id=id)

            serializer = FoodGetSerializer(food)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Food.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            food = Food.objects.get(id=id)
            serializer = FoodPOSTSerializer(
                food, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Food.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def delete(self, requrest, id):
        try:
            food = Food.objects.get(id=id)
            food.delete()
            return Response(status=status.HTTP_201_CREATED)
        except Food.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def addFoodReview(request):
    addSerializer=FoodReviewSerializer(data=request.data)
    if addSerializer.is_valid():
        try:
            foodReview=FoodReview.objects.get(userId=addSerializer.validated_data["userId"],food_id=addSerializer.validated_data["food_id"])
            updateSerialzer=FoodReviewSerializer(foodReview,data=request.data,partial=True)
            if updateSerialzer.is_valid():
                updateSerialzer.save()
                return Response(
                    updateSerialzer.data,
                    
                )
            return Response(
                updateSerialzer.errors,
            )
        except FoodReview.DoesNotExist:
            print("I was here")
            addSerializer.save()
            return Response(
                addSerializer.data
            )
    return Response(addSerializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

@api_view(['POST'])
def addComment(request):
    serializer=AddCommentSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(
            serializer.data,
        )
    return Response(
        serializer.errors,
        status=status.HTTP_400_BAD_REQUEST
    )
    

@api_view(['GET'])
def getTodayAddedFood(request):
    date=str(datetime.today())[0:10]
    print(date)
    food=Food.objects.filter(date=date)
    serializer=FoodGetSerializer(food,many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getComment(request,foodId):
    comment=FoodComment.objects.filter(food_id=foodId)
    serializer=GetCommentSerializer(comment,many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getTotalLike(request,foodId):
    try:
         food=Food.objects.get(id=foodId)
         likes=FoodReview.objects.filter(food_id=food,liked=True)
         return Response({
             "count":likes.count()
         })
    except Food.DoesNotExist:
        return Response(
            {
                "details":"Food Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )


@api_view(['GET'])
def getTotalRating(request,foodId):
    
    try:
        food=Food.objects.get(id=foodId)
        allRatings=FoodReview.objects.filter(food_id=food,rating__gt=0)#Zero rating does not count
        totalRating=0
        for specificUserRating in allRatings:
            totalRating=totalRating+specificUserRating.rating
        averageRating=0
        if allRatings.count()!=0:
            averageRating=totalRating/(allRatings.count())
        return Response(
            {
                "rating":averageRating
            }
        )
    except Food.DoesNotExist:
        return Response(
            {
                "details":"Food Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )