@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forTravel'
@ObjectModel.semanticKey: [ 'TravelID' ]
@Search.searchable: true
define root view entity ZRAP110_C_TRAVELTP_ATTI
  provider contract transactional_query
  as projection on ZRAP110_R_TRAVELTP_ATTI as Travel
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key TravelID,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Agency_StdVH', 
      element: 'AgencyID'
    }
  } ]
  AgencyID,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Customer_StdVH', 
      element: 'CustomerID'
    }
  } ]
  CustomerID,
  BeginDate,
  EndDate,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  BookingFee,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  TotalPrice,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_CurrencyStdVH', 
      element: 'Currency'
    }
  } ]
  CurrencyCode,
  Description,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Overall_Status_VH', 
      element: 'OverallStatus'
    }
  } ]
  OverallStatus,
  Attachment,
  MimeType,
  FileName,
  LastChangedAt,
  CreatedBy,
  CreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  _Booking : redirected to composition child ZRAP110_C_BOOKINGTP_ATTI,
  _Agency,
  _Customer,
  _OverallStatus,
  _Currency
  
}
