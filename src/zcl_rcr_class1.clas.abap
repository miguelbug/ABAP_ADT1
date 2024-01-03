CLASS zcl_rcr_class1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rcr_class1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'hello world' ).
  ENDMETHOD.
ENDCLASS.
