from django.urls import URLPattern, path, include

from restaurant.views import RestaurantApiView, RestaurantDetailApiView, RestaurantLoginApiView, RestaurantSignUpApiView, addComment, addRestaurantReview, getComment, getFavRestaurant, getTotalLike, getTotalRating
urlpatterns = [
    path('restaurant/', RestaurantApiView.as_view()),
    path('restaurantdetail/<int:id>/', RestaurantDetailApiView.as_view()),
    path('restaurantSignup/',RestaurantSignUpApiView.as_view()),
    path('restaurantLogin/',RestaurantLoginApiView.as_view()),
    path('addRestaurantFeedback/',addRestaurantReview),
    path('comment/',addComment),
    path('getFavoriteRestaurant/',getFavRestaurant),
    path('comment/<int:restaurantId>/',getComment),
    path('restaurantTotalLike/<int:restaurantId>/',getTotalLike),
    path('restaurantTotalRating/<int:restaurantId>/',getTotalRating),
]
