CLASS zcl_rcr_11_desc_funct DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rcr_11_desc_funct IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA result TYPE i.

    DATA text    TYPE string VALUE `  ABAP  `.
    DATA substring TYPE string VALUE `AB`.
    DATA offset    TYPE i      VALUE 1.

DATA(string) = text.
* Call different description functions
******************************************************************************
*    result = strlen(     string ).
*    result = numofchar(  string ).


*    result = count(             val = text sub = substring off = offset ).
*    result = find(             val = string sub = substring off = offset ).

*    result = count_any_of(     val = string sub = substring off = offset ).
*    result = find_any_of(      val = string sub = substring off = offset ).
*    result = find_any_of(      val = string sub = substring off = offset ).

*    result = count_any_not_of( val = string sub = substring off = offset ).
    result = find_any_not_of(  val = string sub = substring off = offset ).

    out->write( |Text      = `{ text }`| ).
    out->write( |Substring = `{ substring }` | ).
    out->write( |Offset    = { offset } | ).
    out->write( |Result    = { result } | ).

  ENDMETHOD.
ENDCLASS.
