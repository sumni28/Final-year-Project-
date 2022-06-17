  
from LoginSignUp.models import CustomerUser
from Order.models import UserCart
from Order.serializer import UserCartGetSerializer, UserCartPostSerializer
from restaurant.models import Restaurant
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

from rest_framework.decorators import api_view

@api_view(['POST'])
def addUserCart(request):
    serializer = UserCartPostSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def getUserCart(request,userId):
    try:
        user=CustomerUser.objects.get(id=userId)
        cartItems=UserCart.objects.filter(userId=user)
        serializer=UserCartGetSerializer(cartItems,many=True)
        return Response(serializer.data)
    except CustomerUser.DoesNotExist:
        return Response(
            {
                "details":"User does not exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )

class UserCartDetailApiView(APIView):
    def get(self, request, id):
        try:
            cart = UserCart.objects.get(id=id)
            serializer = UserCartGetSerializer(cart)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except UserCart.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            cart = UserCart.objects.get(id=id)
            serializer = UserCartPostSerializer(
                cart, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except UserCart.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def delete(self, requrest, id):
        try:
            cart = UserCart.objects.get(id=id)
            cart.delete()
            return Response(status=status.HTTP_201_CREATED)
        except UserCart.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)
