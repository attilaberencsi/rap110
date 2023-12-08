CLASS zcl_slimer_ghost_busters DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_slimer_ghost_busters IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    RAISE SHORTDUMP TYPE cx_abap_auth_check_exception
*      EXPORTING
*        textid         =
*        previous       =
*        text           =
*        message_prefix =
    .

    DELETE FROM:  zrap110_atravatt, zrap110_abookatt, zrap110_dbookatt, zrap110_dtravatt.

    out->write( 'Done wiping' ).

  ENDMETHOD.
ENDCLASS.
