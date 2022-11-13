from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from .models import Bookings

from datetime import datetime
from json import loads


@csrf_exempt
def get_bookings_overview(request):
    data = loads(request.body)
    room_num_with_self_booking_arr = []
    MatchingBookings = Bookings.objects.filter(net_id=data["NetID"])
    for Booking in MatchingBookings:
        room_num_with_self_booking_arr.append(Booking.room_num)
    return JsonResponse({
        "RoomNumsWithSelfBookings": room_num_with_self_booking_arr,
        "BookingsLeft": 2 - len(MatchingBookings)
    })


@csrf_exempt
def get_room_bookings(request):
    data = loads(request.body)
    time_arr = []
    for Booking in Bookings.objects.filter(room_num=data["RoomNum"]):
        time_arr.append(Booking.start_time)
    return JsonResponse({"BookingTimeArr": time_arr})


@csrf_exempt
def create_room_bookings(request):
    data = loads(request.body)
    if data["Cancel"]:
        Bookings.objects.filter(
            net_id=data["NetID"],
            room_num=data["RoomNum"],
            start_time=data["StartTime"]
        ).delete()
    else:
        MatchingBookings = Bookings.objects.filter(net_id=data["NetID"])

        if len(MatchingBookings) < 2:
            member = Bookings(
                date=datetime.today(),
                net_id=data["NetID"],
                room_num=data["RoomNum"],
                start_time=data["StartTime"]
            )
            member.save()
        else:
            return JsonResponse({"Successful": False})

    return JsonResponse({"Successful": True})


