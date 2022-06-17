from functools import partial
from .models import Restaurant, RestaurantComment, RestaurantReview
from .serializer import AddCommentSerializer, GetCommentSerializer, RestaurantLoginSerializer, RestaurantRegisterSerializer, RestaurantReviewSerializer, RestaurantSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.decorators import api_view

class RestaurantApiView(APIView):
    def get(self, request):
        restaurant = Restaurant.objects.all()
        serializer = RestaurantSerializer(restaurant, many=True)
        return Response(serializer.data)

    

class RestaurantSignUpApiView(APIView):
    def post(self, request):
        serializer = RestaurantRegisterSerializer(data=request.data)
        if serializer.is_valid():
            try:
                restaurant=Restaurant.objects.get(restaurantName=serializer.validated_data['restaurantName'])
                return Response(
                    {
                        "Details":"Restaurant With That Name Already Exist"
                    },
                    status=status.HTTP_400_BAD_REQUEST
                    )
            except Restaurant.DoesNotExist:
                try:    
                    restaurant=Restaurant.objects.get(restaurantEmail=serializer.validated_data['restaurantEmail'])
                    Response(
                    {
                        "Details":"Restaurant With That Email Already Exist"
                    },
                    status=status.HTTP_400_BAD_REQUEST
                    )
                except Restaurant.DoesNotExist:    
                    serializer.save()
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



@api_view(['POST'])
def addRestaurantReview(request):
    addSerializer=RestaurantReviewSerializer(data=request.data)
    if addSerializer.is_valid():
        try:
            restaurantReview=RestaurantReview.objects.get(userId=addSerializer.validated_data["userId"],restaurantId=addSerializer.validated_data["restaurantId"])
            updateSerialzer=RestaurantReviewSerializer(restaurantReview,data=request.data,partial=True)
            if updateSerialzer.is_valid():
                updateSerialzer.save()
                return Response(
                    updateSerialzer.data,
                    
                )
            return Response(
                updateSerialzer.errors,
            )
        except RestaurantReview.DoesNotExist:
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
def getComment(request,restaurantId):
    comment=RestaurantComment.objects.filter(restaurant_id=restaurantId)
    serializer=GetCommentSerializer(comment,many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getTotalLike(request,restaurantId):
    try:
         restaurant=Restaurant.objects.get(id=restaurantId)
         likes=RestaurantReview.objects.filter(restaurantId=restaurant,RestaurantLiked=True)
         return Response({
             "count":likes.count()
         })
    except Restaurant.DoesNotExist:
        return Response(
            {
                "details":"Restaurant Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )


@api_view(['GET'])
def getTotalRating(request,restaurantId):
    
    try:
        restaurant=Restaurant.objects.get(id=restaurantId)
        allRatings=RestaurantReview.objects.filter(restaurantId=restaurant,restaurantRating__gt=0)#Zero rating does not count
        totalRating=0
        for specificUserRating in allRatings:
            totalRating=totalRating+specificUserRating.restaurantRating
        averageRating=0
        if allRatings.count()!=0:
            averageRating=totalRating/(allRatings.count())
        return Response(
            {
                "rating":averageRating
            }
        )
    except Restaurant.DoesNotExist:
        return Response(
            {
                "details":"Restaurant Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )

class RestaurantLoginApiView(APIView):
    def post(self,request):
        serializer=RestaurantLoginSerializer(data=request.data)
        if serializer.is_valid():
            try:
                restaurant= Restaurant.objects.get(restaurantEmail=serializer.validated_data['restaurantEmail'])
                try:
                    restaurant=Restaurant.objects.get(password=serializer.validated_data['password'])
                    serializer=RestaurantSerializer(restaurant)
                    return Response(
                        serializer.data
                    )
                except Restaurant.DoesNotExist:
                    return Response(
                        {
                            "details":"Invalid Credencials"
                        },
                        status=status.HTTP_400_BAD_REQUEST
                    )
            except Restaurant.DoesNotExist:
                return Response(
                    {
                        "details":"Restaurant Email Does Not Exist, Consider Registering"
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )
            


class RestaurantDetailApiView(APIView):

    def get(self, request, id):
        try:
            restaurant = Restaurant.objects.get(id=id)
            serializer = RestaurantSerializer(restaurant)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Restaurant.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            restaurant = Restaurant.objects.get(id=id)
            serializer = RestaurantSerializer(
                restaurant, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Restaurant.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def delete(self, requrest, id):
        try:
            restaurant = Restaurant.objects.get(id=id)
            restaurant.delete()
            return Response(status=status.HTTP_201_CREATED)
        except Restaurant.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET'])
def getFavRestaurant(request):
    filtedList=RestaurantReview.objects.filter(RestaurantLiked=True)
    restaurantList=[]
    for oneReview in filtedList:
        restaurantList.append(oneReview.restaurantId.id)
    restaurantList=Restaurant.objects.filter(pk__in=restaurantList)
    serializer=RestaurantSerializer(restaurantList,many=True)
    return Response(serializer.data)