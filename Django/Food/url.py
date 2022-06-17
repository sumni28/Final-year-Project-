from django.urls import URLPattern, path, include

from Food.views import FoodApiView, FoodDetailApiView, RestaurantFoodApiView, addComment, addFoodReview, getComment, getTodayAddedFood, getTotalLike, getTotalRating
urlpatterns = [
    path('food/', FoodApiView.as_view()),
    path('food/<int:rest_id>/', RestaurantFoodApiView.as_view()),
    path('fooddetail/<int:id>/', FoodDetailApiView.as_view()),
    path('addFoodFeedback/',addFoodReview),
    path('foodComment/',addComment),
    path('foodComment/<int:foodId>/',getComment),
    path('totalFoodLike/<int:foodId>/',getTotalLike),
    path('totalFoodRating/<int:foodId>/',getTotalRating),
    path('todayFood/',getTodayAddedFood),
    
]
