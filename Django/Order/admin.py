from django.contrib import admin

from Order.models import Order, OrderItem, UserCart
# from .models import FoodOrder, Order, OrderRestaurant, DrinkOrder

admin.site.register(UserCart)
admin.site.register(Order)
admin.site.register(OrderItem)
