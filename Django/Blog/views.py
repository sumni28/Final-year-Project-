from datetime import datetime
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from Blog.models import Blog
from Blog.serializer import BlogGETSerializer, BlogPOSTSerialier
from restaurant.models import Restaurant


class SpecificBlogDetail(APIView):
    def get(self, request,id):
        try:
            blog=Blog.objects.get(id=id)
            serializer=BlogGETSerializer(blog)
            return Response(
                serializer.data
            )
        except Blog.DoesNotExist:
            return Response(
                {
                    "details":"Blog Cannot Be Found",
                },
                status=status.HTTP_400_BAD_REQUEST
            )

    def delete(self, requrest, id):
        try:
            blog = Blog.objects.get(id=id)
            blog.delete()
            return Response(status=status.HTTP_201_CREATED)
        except Blog.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)
    
    def patch(self, request, id):
        try:
            blog = Blog.objects.get(id=id)
            serializer = BlogPOSTSerialier(
                blog, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Blog.DoesNotExist:
            return Response(
                {
                     "details":"Blog Does Not Exist"
                },
                status=status.HTTP_400_BAD_REQUEST
                )


@api_view(['GET'])
def getRestaurantBlog(request,restId):
    try:
        restaurant=Restaurant.objects.get(id=restId)
        blog = Blog.objects.filter(restaurant_id=restaurant)
        serializer = BlogGETSerializer(blog, many=True)
        return Response(serializer.data)
    except Restaurant.DoesNotExist:
        return Response({
            "details":"Restaurant Does Not Exist"
        },
        status=status.HTTP_400_BAD_REQUEST)

class BlogApiView(APIView):
    def get(self, _):
        blog = Blog.objects.all()
        serializer = BlogGETSerializer(blog, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = BlogPOSTSerialier(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def getTodayAddedBlog(request):
    date=str(datetime.today())[0:10]
    print(date)
    blog=Blog.objects.filter(date=date)
    serializer=BlogGETSerializer(blog,many=True)
    return Response(serializer.data)