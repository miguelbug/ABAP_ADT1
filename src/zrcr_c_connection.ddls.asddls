@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRCR_R_CONNECTION'
define root view entity ZRCR_C_CONNECTION
  provider contract transactional_query
  as projection on ZRCR_R_CONNECTION
{
  key UUID,
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRCR_I_CarrierVH', element: 'CarrierID' } }] CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  AirportToID,
  CityTo,
  CountryTo,
  LocalLastChangedAt
  
}
