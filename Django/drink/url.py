from django.urls import URLPattern, path, include

from drink.views import DrinkApiView, DrinkDetailApiView, RestaurantDrinkApiView, addComment, addDrinkReview, getComment, getTodayAddedDrink, getTotalLike, getTotalRating
urlpatterns = [
    path('drink/', DrinkApiView.as_view()),
    path('drink/<int:restId>/', RestaurantDrinkApiView.as_view()),
    path('drinkdetail/<int:id>/', DrinkDetailApiView.as_view()),
    path('addDrinkFeedback/',addDrinkReview),
    path('drinkComment/',addComment),
    path('drinkComment/<int:drinkId>/',getComment),
    path('totalDrinkLike/<int:drinkId>/',getTotalLike),
    path('totalDrinkRating/<int:drinkId>/',getTotalRating),
    path('todayDrink/',getTodayAddedDrink)

]
