CLASS lhc_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    CONSTANTS:
      "booking status
      BEGIN OF booking_status,
        new      TYPE c LENGTH 1 VALUE 'N', "New
        booked   TYPE c LENGTH 1 VALUE 'B', "Booked
        canceled TYPE c LENGTH 1 VALUE 'X', "Canceled
      END OF booking_status.

    METHODS getDaysToFlight FOR READ
      IMPORTING keys FOR FUNCTION Booking~getDaysToFlight RESULT result.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalPrice.

    METHODS setInitialBookingValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~setInitialBookingValues.

    METHODS validateBookingStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateBookingStatus.

ENDCLASS.

CLASS lhc_booking IMPLEMENTATION.

  METHOD getDaysToFlight.
  ENDMETHOD.

  METHOD calculateTotalPrice.
  ENDMETHOD.

  METHOD setInitialBookingValues.
  ENDMETHOD.

  METHOD validateBookingStatus.

    READ ENTITIES OF ZRAP110_R_TravelTP_ATTI IN LOCAL MODE
         ENTITY booking
           FIELDS ( BookingStatus )
           WITH CORRESPONDING #( keys )
         RESULT DATA(bookings).

    LOOP AT bookings INTO DATA(booking).
      CASE booking-BookingStatus.
        WHEN booking_status-new.      " New
        WHEN booking_status-canceled. " Canceled
        WHEN booking_status-booked.   " Booked
        WHEN OTHERS.
          APPEND VALUE #( %tky = booking-%tky ) TO failed-booking.
          APPEND VALUE #( %tky = booking-%tky
                          %msg = NEW /dmo/cm_flight_messages(
                                     textid      = /dmo/cm_flight_messages=>status_invalid
                                     status      = booking-BookingStatus
                                     severity    = if_abap_behv_message=>severity-error )
                          %element-BookingStatus = if_abap_behv=>mk-on
                          %path = VALUE #( travel-TravelId = booking-TravelId )
                        ) TO reported-booking.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
