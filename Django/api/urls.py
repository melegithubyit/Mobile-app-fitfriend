


from django.urls import path, include 
from .views import UserModelViewSet, CategoryViewSet, IncomeViewSet, ExpenseViewSet, CategoryExpenseViewSet, UserViewSet, AdminApiView, DeleteUserAPiView, UserDetailViewSet
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenVerifyView
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)


router = DefaultRouter()
router.register("register", UserModelViewSet)
router.register("categories", CategoryViewSet)
router.register("incomes", IncomeViewSet)
router.register("expenses", ExpenseViewSet)
router.register("categoryexpenses", CategoryExpenseViewSet)
router.register("user", UserViewSet)
router.register("userdetail", UserDetailViewSet)




urlpatterns = [
    
    path('',include(router.urls)),
    path('login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    path("roles/", AdminApiView.as_view()),
    path("deleteuser/<int:pk>/", DeleteUserAPiView.as_view() )

]
