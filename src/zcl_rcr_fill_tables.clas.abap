CLASS zcl_rcr_fill_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rcr_fill_tables IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    data: LT_CARRIER TYPE STANDARD TABLE OF /dmo/carrier,
          LWA_CARRIER LIKE LINE OF LT_CARRIER.

  "FILL TABLE /DMO/CARRIER TO COULD TEST.
    LWA_CARRIER = VALUE #( carrier_id = 'LAN'  name = 'LAN AIRLINES' CURRENCY_CODE = 'USD'
                       local_created_at = cl_abap_context_info=>get_system_date( )  local_created_by = sy-uname ).
    append lwa_carrier to lt_carrier.
    MODIFY /dmo/carrier from TABLE @lt_carrier.

  ENDMETHOD.
ENDCLASS.
