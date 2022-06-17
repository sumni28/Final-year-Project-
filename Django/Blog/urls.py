from django.urls import URLPattern, path, include

from Blog.views import BlogApiView, SpecificBlogDetail, getRestaurantBlog, getTodayAddedBlog
urlpatterns = [
    #path('drink/', DrinkApiView.as_view()),
    path('blog/',BlogApiView.as_view()),
    path('blog/<int:id>/',SpecificBlogDetail.as_view()),
    path('restaurantBlog/<int:restId>/',getRestaurantBlog),
    path('todayBlog/',getTodayAddedBlog),
]