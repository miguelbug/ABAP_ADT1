CLASS zcl_rcr_11_text_funct DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rcr_11_text_funct IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA text   TYPE string VALUE `  Let's talk about ABAP  `.
    DATA result TYPE i.

    out->write(  text ).

    result = find( val = text sub = 'A' ).  out->write( |RESULT = { result } | ).
*
    result = find( val = text sub = 'A' case = abap_false ).  out->write( |RESULT = { result } | ).
*
    result = find( val = text sub = 'A' case = abap_false occ =  -1 ).out->write( |RESULT = { result } | ).
    result = find( val = text sub = 'A' case = abap_false occ =  -2 ).out->write( |RESULT = { result } | ).
    result = find( val = text sub = 'A' case = abap_false occ =   2 ).out->write( |RESULT = { result } | ).
*
    result = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 ).out->write( |RESULT = { result } | ).
    result = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 len = 4 ).

    out->write( |RESULT = { result } | ).

  ENDMETHOD.
ENDCLASS.
