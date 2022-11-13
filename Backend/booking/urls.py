#!/usr/bin/env python3

from django.contrib import admin
from django.urls import path, include

from . import views

urlpatterns = [
    path('overview', views.get_bookings_overview, name='get_bookings_overview'),
    path('viewing', views.get_room_bookings, name='get_room_bookings'),
    path('creating', views.create_room_bookings, name='create_room_bookings'),
]
