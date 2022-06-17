from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from Food.models import Food
from LoginSignUp.models import CustomerUser
from Order.models import Order, OrderItem
from Order.serializer import OrderGETSerializer, OrderItemGETSerializer, OrderItemPOSTSerializer, OrderPOSTSerializer
from drink.models import Drink
from restaurant.models import Restaurant
from django.db.models import Q

@api_view(['POST'])
def addOrder(request):
    serializer = OrderPOSTSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



class SpecificOrderAPIView(APIView):
    def get(self, _, id):
        try:
            order = Order.objects.get(id=id)
            serializer = OrderPOSTSerializer(order)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Order.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            order = Order.objects.get(id=id)
            serializer = OrderPOSTSerializer(
                order, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Order.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def getUserOrders(_,userId):
    try:
        user=CustomerUser.objects.get(id=userId)
        orders=Order.objects.filter(user=user,userReceived=False)
        serializer=OrderGETSerializer(orders,many=True)
        return Response(serializer.data)
    except CustomerUser.DoesNotExist:
        return Response(
            {
                "details":"User Does Not Exist"
            },
            status= status.HTTP_400_BAD_REQUEST
        )

@api_view(['GET'])
def getRestaurantOrders(_,restaurantId):
    try:
        restaurant=Restaurant.objects.get(id=restaurantId)
        orders=Order.objects.filter(Q(restaurant=restaurant,userReceived=False) | Q(restaurant=restaurant,forDonating=True,restaurantDelivered=False) )
        serializer=OrderGETSerializer(orders,many=True)
        return Response(serializer.data)
    except Restaurant.DoesNotExist:
        return Response(
            {
                "details":"Restaurant Does Not Exist"
            },
            status= status.HTTP_400_BAD_REQUEST
        )

@api_view(['POST'])
def addMultipleOrderItems(request):
    serializer=OrderItemPOSTSerializer(data=request.data,many=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def getOrderItems(request,orderId):
    try:
        order=Order.objects.get(id=orderId)
        orderItems=OrderItem.objects.filter(order=order)
        serializer=OrderItemGETSerializer(orderItems,many=True)
        return Response(serializer.data)
    except Order.DoesNotExist:
        return Response(
            {"details":"Order Id Does Not Exist"},
            status=status.HTTP_400_BAD_REQUEST
        )

@api_view(['GET'])
def getFoodOrderCount(request,foodId):
    try:
        food=Food.objects.get(id=foodId)
        orderItems=OrderItem.objects.filter(food=food)
        total=0
        for individualItem in orderItems.iterator():
            total=individualItem.quantity+total
        return Response(
            {
                "count":total
            }
        )
    except Food.DoesNotExist:
        return Response(
            {
                "details":"Food Not Found"
            },
            status=status.HTTP_400_BAD_REQUEST
        )
@api_view(['GET'])
def getDrinkOrderCount(request,drinkId):
    try:
        drink=Drink.objects.get(id=drinkId)
        orderItems=OrderItem.objects.filter(drink=drink)
        total=0
        for individualItem in orderItems.iterator():
            total=individualItem.quantity+total
        return Response(
            {
                "count":total
            }
        )
    except Drink.DoesNotExist:
        return Response(
            {
                "details":"Drink Not Found"
            },
            status=status.HTTP_400_BAD_REQUEST
        )

@api_view(['GET'])
def getUserTotalDonation(_,userId):
    try:
        user=CustomerUser.objects.get(id=userId)
        allOrders=Order.objects.filter(forDonating=True,user=user)
        totalDonation=0
        donatedTimes=0
        for singleOrder in allOrders:
            donatedTimes=donatedTimes+1
            totalDonation=singleOrder.totalPrice+totalDonation
        return Response(
            {
                "donatedTimes":donatedTimes,
                "user":user.username,
                "gmail":user.email,
                "totalDonation":totalDonation
            }
        )

    except CustomerUser.DoesNotExist:
        return Response(
            {"details":"User Does Not Exist"},
            status=status.HTTP_400_BAD_REQUEST
        )

