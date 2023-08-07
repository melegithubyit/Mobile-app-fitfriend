from rest_framework import serializers 
from django.contrib.auth import get_user_model
from .models import Category, Income , Expense

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):

    password = serializers.CharField(write_only = True )

    class Meta:
        fields = ["username", "password", ]
        model = User

    def create(self, validated_data):
        user = User.objects.create_user(username=validated_data["username"], password=validated_data["password"])
        return user


class CategorySerializer(serializers.ModelSerializer):

    total_expense = serializers.SerializerMethodField()

    class Meta:
        model = Category
        fields = ["id", "title", "total_budget", "total_expense", "user"]
        read_only_fields = ["user"]

    def get_total_expense(self, obj):
        return obj.get_total_expense()


class IncomeSerializer(serializers.ModelSerializer):

    total_expense = serializers.SerializerMethodField()

    class Meta:
        model = Income  
        fields = ["id", "income", "total_expense", "user"]
        read_only_fields = ["user"]

    def get_total_expense(self, obj):
        user = self.context.get("request").user
        categories = Category.objects.filter(user=user)
        return sum([cat.get_total_expense() for cat in categories])


class ExpenseSerializer(serializers.ModelSerializer):

    class Meta:
        model = Expense
        fields = ["id", "amount", "date", "category" ]


class UserDetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = User 
        fields = ["id", "username", "is_staff", "is_superuser"]

