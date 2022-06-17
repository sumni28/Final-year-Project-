from .views import RegisterAPI, getUserId
from django.urls import path
from knox import views as knox_views
from .views import LoginAPI
from django.urls import path
#from .views import ChangePasswordView


urlpatterns = [
    path('register/', RegisterAPI.as_view(), name='register'),
    path('login/', LoginAPI.as_view(), name='login'),
    path('logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('logoutall/', knox_views.LogoutAllView.as_view(), name='logoutall'),
    path('getUserId/', getUserId,),
    # path('change-password/', ChangePasswordView.as_view(),
    #      name='change-password'),

]
