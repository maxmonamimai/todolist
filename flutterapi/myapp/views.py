from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.decorators import api_view # Decorator
from rest_framework import status # STATUS
from .serializers import TodoList_Serializer # From serializres.py

from .models import *

# GET DATA
@api_view(['GET'])
def all_todolist(request):
    alltodolist = TodoList.objects.all()
    serializer = TodoList_Serializer(alltodolist, many = True)
    return Response(serializer.data, status = status.HTTP_200_OK)

# POST Data [Save]
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodoList_Serializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_404_NOT_FOUND)

# Update Data
@api_view(['PUT'])
def update_todolist(request, TID):
    todo = TodoList.objects.get(id=TID)
    if request.method == 'PUT':
        data = {}
        serializer = TodoList_Serializer(todo, data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'updated'
            return Response(data=data, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_404_NOT_FOUND)

# Delete Data
@api_view(['DELETE'])
def delete_todolist(request, TID):
    if request.method == 'DELETE':
        todo = TodoList.objects.get(id=TID)
        delete = todo.delete()
        data = {}

        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        
        return Response(data=data, status=statuscode)

data = [{ "title": "What's computer?", "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "img_url": "https://raw.githubusercontent.com/maxmonamimai/BasicAPI/main/img2.jpeg", "detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum" }, { "title": "What's graphic card?", "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "img_url": "https://raw.githubusercontent.com/maxmonamimai/BasicAPI/main/img3.jpeg", "detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum" }, { "title": "What's JSON?", "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "img_url": "https://raw.githubusercontent.com/maxmonamimai/BasicAPI/main/img4.jpeg", "detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum" }, { "title": "What's Jamago?", "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "img_url": "https://raw.githubusercontent.com/maxmonamimai/BasicAPI/main/img1.jpeg", "detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum" }, { "title": "Who's created This App?", "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "img_url": "https://raw.githubusercontent.com/maxmonamimai/BasicAPI/main/img1.jpeg", "detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum" }]

def Home(request):
    return JsonResponse(data=data, safe=False, json_dumps_params = {'ensure_ascii':False})
