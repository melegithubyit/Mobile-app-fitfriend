# Generated by Django 4.2.1 on 2023-05-20 18:01

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_remove_category_total_expense'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='income',
            name='total_expense',
        ),
    ]
