from django.contrib import admin
from .models import Income, Category, Expense


class IncomeAdmin(admin.ModelAdmin):

    model = Income
    list_display = ["id", "user", "income"]
    search_fields = ["user"]


class CategoryAdmin(admin.ModelAdmin):

    model = Category
    list_display = ["id", "title", "total_budget", "user"]
    search_fields = ["user"]


class ExpenseAdmin(admin.ModelAdmin):

    model = Expense
    list_display = ["id", "amount", "date", "category"]
    search_fields = ["category"]

admin.site.register(Income, IncomeAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Expense, ExpenseAdmin)