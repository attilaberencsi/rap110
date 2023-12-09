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
    " Read all parent IDs
    READ ENTITIES OF ZRAP110_R_TravelTP_ATTI IN LOCAL MODE
      ENTITY Booking BY \_Travel
        FIELDS ( TravelID  )
        WITH CORRESPONDING #(  keys  )
      RESULT DATA(travels).

    " Trigger Re-Calculation on Root Node
    MODIFY ENTITIES OF ZRAP110_R_TravelTP_ATTI IN LOCAL MODE
      ENTITY Travel
        EXECUTE reCalcTotalPrice
          FROM CORRESPONDING  #( travels ).
  ENDMETHOD.

  METHOD setInitialBookingValues.

    "Set initial values for BookingDate, BookingStatus, and CustomerID

    "Read all travels for the requested bookings
    " If multiple bookings of the same travel are requested, the travel is returned only once.
    READ ENTITIES OF ZRAP110_R_TravelTP_ATTI IN LOCAL MODE
      ENTITY Booking BY \_Travel
        FIELDS ( CustomerID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(travels) LINK DATA(booking_to_travel).

    "Read all bookings
    READ ENTITIES OF ZRAP110_R_TravelTP_ATTI IN LOCAL MODE
      ENTITY Booking
        FIELDS ( TravelID CustomerID BookingDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    DATA: update TYPE TABLE FOR UPDATE zrap110_r_traveltp_ATTI\\Booking.
    update = CORRESPONDING #( bookings ).
    DELETE update WHERE CustomerID IS NOT INITIAL AND BookingDate IS NOT INITIAL AND BookingStatus IS NOT INITIAL.

    LOOP AT update ASSIGNING FIELD-SYMBOL(<update>).
      IF <update>-CustomerID IS INITIAL.
        <update>-CustomerID = travels[ KEY id %tky = booking_to_travel[ KEY id source-%tky = <update>-%tky ]-target-%tky ]-CustomerID.
        <update>-%control-CustomerID = if_abap_behv=>mk-on.
      ENDIF.

      IF <update>-BookingDate IS INITIAL.
        <update>-BookingDate = cl_abap_context_info=>get_system_date( ).
        <update>-%control-BookingDate = if_abap_behv=>mk-on.
      ENDIF.

      IF <update>-BookingStatus IS INITIAL.
        <update>-BookingStatus = booking_status-new.
        <update>-%control-BookingStatus = if_abap_behv=>mk-on.
      ENDIF.
    ENDLOOP.

    IF update IS NOT INITIAL.
      MODIFY ENTITIES OF ZRAP110_R_TravelTP_ATTI IN LOCAL MODE
      ENTITY Booking
        UPDATE FROM update.
    ENDIF.

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
