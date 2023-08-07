from rest_framework.viewsets import ModelViewSet
from rest_framework.views import APIView
from django.contrib.auth import get_user_model
from .serializer import UserSerializer, CategorySerializer, IncomeSerializer, ExpenseSerializer, UserDetailSerializer
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from .models import Category, Income, Expense
from rest_framework.exceptions import ValidationError
from .permissions import UserPermission, GetOnlyPermission
from rest_framework.response import Response


User = get_user_model()


class UserModelViewSet(ModelViewSet):

    permission_classes = [AllowAny]
    authentication_classes = []
    serializer_class = UserSerializer
    queryset = User.objects.all()


class CategoryViewSet(ModelViewSet):

    serializer_class = CategorySerializer
    queryset = Category.objects.all()
    
    def get_queryset(self):

        user = self.request.user 
        query_set = Category.objects.filter(user= user)

        return query_set

    def perform_create(self, serializer):
        
        return serializer.save(user = self.request.user)


class IncomeViewSet(ModelViewSet):

    serializer_class = IncomeSerializer
    queryset = Income.objects.all()

    def get_queryset(self):

        user = self.request.user 
        query_set = Income.objects.filter(user= user)

        return query_set

    def perform_create(self, serializer):
        print(self.request.user)
        try:
            income = serializer.save(user = self.request.user)
            
            return income 
        except:
            raise ValidationError({"income" : ["An income already exists for this user."]})


class ExpenseViewSet(ModelViewSet):

    serializer_class = ExpenseSerializer 
    queryset = Expense.objects.all()

    def get_queryset(self):

        user = self.request.user 
        query_set = Expense.objects.filter(category__user= user)


        return query_set
    

class CategoryExpenseViewSet(ModelViewSet):

    serializer_class = ExpenseSerializer 
    queryset = Expense.objects.all()

    def list(self, request, *args, **kwargs):

        categoryID = request.query_params.get("categoryID")
        if not categoryID:
            return Response(["query parameter required"])
        category = CategorySerializer(Category.objects.filter(id=categoryID).first()).data 
        print(category, categoryID)
        if category.get("user") != request.user.id:
            return Response(["data not found"])
        
        expenses = Expense.objects.filter(category=categoryID)
        serializer = ExpenseSerializer(expenses, many=True).data
        
        return Response(serializer, status=200)
    
    def create(self, request, *args, **kwargs):

        categoryID = self.request.data.get("category")
        category = CategorySerializer(Category.objects.filter(id=categoryID).first()).data 

        if category.get('user') != request.user.id:
            return Response(["you don't have the permission to perform this action"], status=201)
        
        return super().create(request, *args, **kwargs)

    def get_queryset(self):
        query_set = Expense.objects.filter(category__user = self.request.user.id)
        return query_set

class UserViewSet(ModelViewSet):

    permission_classes = [IsAuthenticated, UserPermission]
    serializer_class = UserSerializer
    queryset = User.objects.all()

    def get_queryset(self):
        query_set = User.objects.filter(id=self.request.user.id)
        return query_set
    
    def update(self, request, *args, **kwargs):

        instance = self.get_object()
        print(instance)
        serializer = self.get_serializer(instance, data=request.data, partial= True)
        serializer.is_valid(raise_exception=True)
        
        if request.data.get("oldPassword"):
            
            if not instance.check_password(request.data.get("oldPassword")):
                return Response({'password': 'Incorrect old password.'}, status=400)
            if not request.data.get("newPassword"):
                return Response({"password": "Invalid new password"})
            instance.set_password(request.data.get('newPassword'))
            instance.save()
        if not request.data.get("oldPassword"):
            if request.data.get("newPassword"):
                return Response({"password": "Invalid old password"})
        if not request.data.get("newPassword"):
            if request.data.get("oldPassword"):
                return Response({"password": "Invalid old password"})
        
        if request.data.get("newPassword"):
            if request.data.get("oldPassword"):
                return super().update(request, *args, **kwargs)
        
        return super().update(request, *args, **kwargs)


class AdminApiView(APIView):

    permission_classes = [IsAuthenticated, IsAdminUser]

    def post(self, request):

        userID = request.data.get("userID")
        action = request.data.get("action")

        if userID and action:
            try:
                user = User.objects.get(id=userID)
            except User.DoesNotExist:
                return Response({'error': 'User not found.'}, status=404)

            
            if action == 'revoke':
                user.is_staff = False
                user.is_superuser = False
            elif action == 'give':
                user.is_staff = True
                user.is_superuser = True
            else:
                return Response({'error': 'Invalid action.'}, status=400)

            user.save()

            return Response({'message': 'User role updated successfully.'}, status=200)

    def get(self, request):
    
        users = User.objects.all()
        serializer = UserDetailSerializer(users, many=True).data
        return Response(serializer, status=200)


class DeleteUserAPiView(APIView):

    permission_classes = [IsAuthenticated, IsAdminUser]

    def delete(self, request, pk):
        
        try:
            user = User.objects.get(id=pk)
            user.delete()
        except: 
            return Response(status=404)
        return Response( status=204)


class UserDetailViewSet(ModelViewSet):

    serializer_class = [UserDetailSerializer, GetOnlyPermission] 
    queryset = User.objects.all()

    def list(self, request, *args, **kwargs):

        user = User.objects.get(id= request.user.id)

        return Response(UserDetailSerializer(user).data, status=200) 
        
