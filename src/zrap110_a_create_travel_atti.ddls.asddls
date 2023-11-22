@EndUserText.label: 'Parameter for Creating Travel+Booking'
define abstract entity ZRAP110_A_Create_Travel_ATTI
{
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Customer_StdVH', 
      element: 'CustomerID'
    }
  } ]
  customer_id : /DMO/CUSTOMER_ID;
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight_StdVH', 
      element: 'AirlineID'
    }, 
    additionalBinding: [ {
      localElement: 'flight_date', 
      element: 'FlightDate', 
      usage: #RESULT
    }, {
      localElement: 'connection_id', 
      element: 'ConnectionID', 
      usage: #RESULT
    } ]
  } ]
  carrier_id : /DMO/CARRIER_ID;
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight_StdVH', 
      element: 'AirlineID'
    }, 
    additionalBinding: [ {
      localElement: 'flight_date', 
      element: 'FlightDate', 
      usage: #RESULT
    }, {
      localElement: 'carrier_id', 
      element: 'AirlineID', 
      usage: #FILTER_AND_RESULT
    } ]
  } ]
  connection_id : /DMO/CONNECTION_ID;
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/DMO/I_Flight_StdVH', 
      element: 'AirlineID'
    }, 
    additionalBinding: [ {
      localElement: 'carrier_id', 
      element: 'AirlineID', 
      usage: #FILTER_AND_RESULT
    }, {
      localElement: 'connection_id', 
      element: 'ConnectionID', 
      usage: #FILTER_AND_RESULT
    } ]
  } ]
  flight_date : /DMO/FLIGHT_DATE;
  
}
