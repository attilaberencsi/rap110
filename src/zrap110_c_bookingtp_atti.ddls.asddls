@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forBooking'
@ObjectModel.semanticKey: [ 'BookingID' ]
@Search.searchable: true
define view entity ZRAP110_C_BOOKINGTP_ATTI
  as projection on ZRAP110_R_BOOKINGTP_ATTI as Booking
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key TravelID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key BookingID,
  BookingDate,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Customer_StdVH', 
      element: 'CustomerID'
    }
  } ]
  CustomerID,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight', 
      element: 'AirlineID'
    }, 
    additionalBinding: [ {
      localElement: 'FlightDate', 
      element: 'FlightDate', 
      usage: #RESULT
    }, {
      localElement: 'ConnectionID', 
      element: 'ConnectionID', 
      usage: #RESULT
    }, {
      localElement: 'FlightPrice', 
      element: 'Price', 
      usage: #RESULT
    }, {
      localElement: 'CurrencyCode', 
      element: 'CurrencyCode', 
      usage: #RESULT
    } ]
  } ]
  CarrierID,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight', 
      element: 'ConnectionID'
    }, 
    additionalBinding: [ {
      localElement: 'FlightDate', 
      element: 'FlightDate', 
      usage: #RESULT
    }, {
      localElement: 'CarrierID', 
      element: 'AirlineID', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'FlightPrice', 
      element: 'Price', 
      usage: #RESULT
    }, {
      localElement: 'CurrencyCode', 
      element: 'CurrencyCode', 
      usage: #RESULT
    } ]
  } ]
  ConnectionID,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight', 
      element: 'FlightDate'
    }, 
    additionalBinding: [ {
      localElement: 'CarrierID', 
      element: 'AirlineID', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'ConnectionID', 
      element: 'ConnectionID', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'FlightPrice', 
      element: 'Price', 
      usage: #RESULT
    }, {
      localElement: 'CurrencyCode', 
      element: 'CurrencyCode', 
      usage: #RESULT
    } ]
  } ]
  FlightDate,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Booking_Status_VH', 
      element: 'BookingStatus'
    }
  } ]
  BookingStatus,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight', 
      element: 'Price'
    }, 
    additionalBinding: [ {
      localElement: 'CarrierID', 
      element: 'AirlineID', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'ConnectionID', 
      element: 'ConnectionID', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'FlightDate', 
      element: 'FlightDate', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'CurrencyCode', 
      element: 'CurrencyCode', 
      usage: #RESULT
    } ]
  } ]
  FlightPrice,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_CurrencyStdVH', 
      element: 'Currency'
    }
  } ]
  CurrencyCode,
  LocalLastChangedAt,
  _Travel : redirected to parent ZRAP110_C_TRAVELTP_ATTI,
  _Customer,
  _Carrier,
  _Connection,
  _Flight,
  _BookingStatus,
  _Currency
  
}
