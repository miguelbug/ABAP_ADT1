CLASS lhc_nameconnection DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR NameConnection
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR NameConnection~checkSemanticKey,
      CheckCarrierId FOR VALIDATE ON SAVE
        IMPORTING keys FOR NameConnection~CheckCarrierId,
      CheckOriginDestination FOR VALIDATE ON SAVE
        IMPORTING keys FOR NameConnection~CheckOriginDestination,
      GetCities FOR DETERMINE ON SAVE
        IMPORTING keys FOR NameConnection~GetCities.
ENDCLASS.

CLASS lhc_nameconnection IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD CheckSemanticKey.
    READ ENTITIES OF ZRCR_r_connection IN LOCAL MODE ENTITY NameConnection
                FIELDS ( CarrierID ConnectionID )
                WITH CORRESPONDING #( keys )
                RESULT DATA(connections).
    LOOP AT connections INTO DATA(connection).
      SELECT FROM zrcraconn
          FIELDS uuid
          WHERE carrier_id = @connection-CarrierID AND connection_id = @connection-ConnectionID
              AND uuid <> @connection-uuid
       UNION

       SELECT FROM zrcrdconn
       FIELDS uuid
       WHERE carrierid = @connection-CarrierID AND connectionid = @connection-ConnectionID
       AND uuid <> @connection-uuid

       INTO TABLE @DATA(check_result).

      IF check_result IS NOT INITIAL.
        DATA(message) = me->new_message( id = 'ZS4D400' number = '001'
                                         severity = ms-error v1 = connection-CarrierID v2 = connection-ConnectionID ).

        DATA reported_record LIKE LINE OF reported-NameConnection.
        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-CarrierID = if_abap_behv=>mk-on.
        reported_record-%element-ConnectionID = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-Nameconnection.

        DATA failed_record LIKE LINE OF failed-Nameconnection.
        failed_record-%tky = connection-%tky.
        APPEND failed_record TO failed-Nameconnection.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD CheckCarrierId.
    READ ENTITIES OF ZRCR_r_connection
      IN LOCAL MODE ENTITY NameConnection
      FIELDS ( CarrierID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(connections).
    LOOP AT connections INTO DATA(connection).
      SELECT SINGLE FROM /DMO/I_Carrier
        FIELDS @abap_true
        WHERE airlineid = @connection-CarrierID
        INTO @DATA(exists).
      IF exists = abap_false.
        DATA(message) = me->new_message( id = 'ZS4D400' number = '002' severity = ms-error v1 = connection-CarrierID ) .
        DATA reported_record LIKE LINE OF reported-nameconnection.
        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrierid = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-nameconnection.
        DATA failed_record LIKE LINE OF failed-nameconnection.
        failed_record-%tky = connection-%tky.
        APPEND failed_Record TO failed-nameconnection.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD CheckOriginDestination.
    READ ENTITIES OF zrcr_r_Connection
    IN LOCAL MODE ENTITY NameConnection
    FIELDS ( AirportFromID AirportToID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).
      IF connection-AirportFromID = connection-AirportToID.
        DATA(message) = me->new_message( id = 'ZS4D400' number = '003' severity = ms-error ).
        DATA reported_record LIKE LINE OF reported-nameconnection.
        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-AirportFromID = if_abap_behv=>mk-on.
        reported_record-%element-AirportToID = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-nameconnection.
        DATA failed_record LIKE LINE OF failed-nameconnection.
        failed_record-%tky = connection-%tky.
        APPEND failed_record TO failed-nameconnection.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD GetCities.
    READ ENTITIES OF zrcr_r_connection
    IN LOCAL MODE ENTITY nameConnection
    FIELDS ( AirportFromID AirportToID )
    WITH CORRESPONDING #( keys ) RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).
      SELECT SINGLE FROM /DMO/I_Airport
      FIELDS city, CountryCode
      WHERE AirportID = @connection-AirportFromID
      INTO ( @connection-CityFrom, @connection-CountryFrom ).

      SELECT SINGLE FROM /DMO/I_Airport
      FIELDS city, CountryCode
      WHERE AirportID = @connection-AirportToID
      INTO ( @connection-CityTo, @connection-CountryTo ).

      MODIFY connections FROM connection.
    ENDLOOP.

    DATA connections_upd TYPE TABLE FOR UPDATE zRCR_r_connection.
    connections_upd = CORRESPONDING #( connections ).

    MODIFY ENTITIES OF zrcr_r_connection
    IN LOCAL MODE ENTITY nameConnection
    UPDATE FIELDS ( CityFrom CountryFrom CityTo CountryTo )
    WITH connections_upd
    REPORTED DATA(reported_records).
    reported-nameconnection = CORRESPONDING #( reported_records-nameconnection ).

  ENDMETHOD.

ENDCLASS.
