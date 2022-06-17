from django.urls import URLPattern, path, include

from Order.views import SpecificOrderAPIView, addMultipleOrderItems, addOrder, getDrinkOrderCount, getFoodOrderCount, getOrderItems, getRestaurantOrders, getUserOrders, getUserTotalDonation
from .cart_view import UserCartDetailApiView, addUserCart, getUserCart
urlpatterns = [
    path('cart/', addUserCart),
    path('cart/<int:id>/', UserCartDetailApiView.as_view()),
    path('usercart/<int:userId>/', getUserCart),
    path('order/',addOrder),
    path('order/<int:id>/',SpecificOrderAPIView.as_view()),
    path('userOrder/<int:userId>/',getUserOrders),
    path('restaurantOrder/<int:restaurantId>/',getRestaurantOrders),
    path('orderItem/',addMultipleOrderItems),
    path('orderItem/<int:orderId>/',getOrderItems),
    path('getTotalFoodOrders/<int:foodId>/',getFoodOrderCount),
    path('getTotalDrinkOrders/<int:drinkId>/',getDrinkOrderCount),
    path('getUserTotalDonation/<int:userId>/',getUserTotalDonation),


]