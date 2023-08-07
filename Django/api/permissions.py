from rest_framework.permissions import BasePermission
from .models import Category
from .serializer import CategorySerializer


class UserPermission(BasePermission):

    def has_permission(self, request, view):
        
        if request.method not in ["DELETE", "PATCH"]:
            return False 
        return super().has_permission(request, view)


class GetOnlyPermission(BasePermission):

    def has_permission(self, request, view):

        if request.method != "GET":
            return False 
        return super().has_permission(request, view)