from datetime import datetime
from restaurant.models import Restaurant
from .models import Drink, DrinkComment, DrinkReview
from .serializer import AddCommentSerializer, DrinkPOSTSerializer, DrinkReviewSerializer, DrinkGETSerializer, GetCommentSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

from rest_framework.decorators import api_view


class RestaurantDrinkApiView(APIView):
    def get(self, request,restId):
        try:
            restaurant=Restaurant.objects.get(id=restId)
            drink = Drink.objects.filter(restaurant_id=restaurant)
            serializer = DrinkGETSerializer(drink, many=True)
            return Response(serializer.data)
        except Restaurant.DoesNotExist:
            return Response({
                "details":"Restaurant Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST)
        
   

class DrinkApiView(APIView):
    def get(self, request):
        drink = Drink.objects.all()
        serializer = DrinkGETSerializer(drink, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = DrinkPOSTSerializer(data=request.data)
        if serializer.is_valid():
          
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class DrinkDetailApiView(APIView):

    def get(self, request, id):
        try:
            drink = Drink.objects.get(id=id)

            serializer = DrinkGETSerializer(drink)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Drink.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            drink = Drink.objects.get(id=id)
            serializer = DrinkPOSTSerializer(
                drink, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Drink.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def delete(self, requrest, id):
        try:
            drink = Drink.objects.get(id=id)
            drink.delete()
            return Response(status=status.HTTP_201_CREATED)
        except Drink.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

            
@api_view(['POST'])
def addDrinkReview(request):
    addSerializer=DrinkReviewSerializer(data=request.data)
    if addSerializer.is_valid():
        try:
            drinkReview=DrinkReview.objects.get(userId=addSerializer.validated_data["userId"],drink_id=addSerializer.validated_data["drink_id"])
            updateSerialzer=DrinkReviewSerializer(drinkReview,data=request.data,partial=True)
            if updateSerialzer.is_valid():
                updateSerialzer.save()
                return Response(
                    updateSerialzer.data,
                    
                )
            return Response(
                updateSerialzer.errors,
            )
        except DrinkReview.DoesNotExist:
            print("I was here")
            addSerializer.save()
            return Response(
                addSerializer.data
            )
    return Response(addSerializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

@api_view(['GET'])
def getTodayAddedDrink(request):
    date=str(datetime.today())[0:10]
    print(date)
    drink=Drink.objects.filter(date=date)
    serializer=DrinkGETSerializer(drink,many=True)
    return Response(serializer.data)

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
def getComment(request,drinkId):
    comment=DrinkComment.objects.filter(drink_id=drinkId)
    serializer=GetCommentSerializer(comment,many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getTotalLike(request,drinkId):
    try:
         drink=Drink.objects.get(id=drinkId)
         likes=DrinkReview.objects.filter(drink_id=drink,liked=True)
         return Response({
             "count":likes.count()
         })
    except Drink.DoesNotExist:
        return Response(
            {
                "details":"Drink Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )


@api_view(['GET'])
def getTotalRating(request,drinkId):
    
    try:
        drink=Drink.objects.get(id=drinkId)
        allRatings=DrinkReview.objects.filter(drink_id=drink,rating__gt=0)#Zero rating does not count
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
    except Drink.DoesNotExist:
        return Response(
            {
                "details":"Drink Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )

