from django.db import models
from django.contrib.auth import get_user_model


User = get_user_model()


class Income(models.Model):

    income = models.FloatField()
    # total_expense = models.FloatField(default=0)
    user = models.OneToOneField(User, on_delete=models.CASCADE)


    def __str__(self) -> str:
        return str(self.income)


class Category(models.Model):

    title = models.CharField(max_length=200, unique=True )
    total_budget = models.FloatField(default=0)
    # total_expense = models.FloatField(default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE )

    def __str__(self) -> str:
        return self.title
    
    def get_total_expense(self):
        return sum([ex.amount for ex in Expense.objects.filter(category=self)])

 
class Expense(models.Model):

    amount = models.FloatField()
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return str(self.amount)
    

