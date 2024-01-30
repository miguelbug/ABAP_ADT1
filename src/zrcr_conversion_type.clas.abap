CLASS zrcr_conversion_type DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrcr_conversion_type IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "SUBJECT 10 - Using Data Types and Type Conversions Correctly

    DATA var_string TYPE string.
    DATA var_int TYPE i.
    DATA var_date TYPE d.
    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.

    out->write( 'CASE1: "Successful Assignments" ' ).
    var_string = `12345`.
    var_int = var_string.

    out->write( 'Conversion successful' ).

    var_string = `20230101`.
    var_date = var_string.

    out->write( |String value: { var_string }| ).
    out->write( |Date Value: { var_date DATE = USER }| ).

******************************************************
    "CASE 2:  Truncation and Rounding
    DATA long_char TYPE c LENGTH 10.
    DATA short_char TYPE c LENGTH 5.

    DATA result TYPE p LENGTH 3 DECIMALS 2.

    out->write( 'CASE2: "Truncation and Rounding" ' ).
    long_char = 'ABCDEFGHIJ'.
    short_char = long_char.

    out->write( long_char ).
    out->write( short_char ).

    result = 1 / 8.
    out->write( |1 / 8 is rounded to { result }| ).


*******************************************************
    "CASE3 Unexpected Results of Assignments

*    DATA var_date TYPE d.
*    DATA var_int TYPE i.
*    DATA var_string TYPE string.
    CLEAR: var_date, var_int, var_string.
    DATA var_n TYPE n LENGTH 4.

    out->write( 'CASE3: "Unexpected Results of Assignments" ' ).
    var_date = cl_abap_context_info=>get_system_date( ).
    var_int = var_date.

    out->write( |Date as date| ).
    out->write( var_date ).
    out->write( |Date assigned to integer| ).
    out->write( var_int ).

    var_string = `R2D2`.
    var_n = var_string.

    out->write( |String| ).
    out->write( var_string ).
    out->write( |String assigned to type N| ).
    out->write( var_n ).

  ENDMETHOD.
ENDCLASS.
