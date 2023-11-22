@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forBooking'
define view entity ZRAP110_R_BOOKINGTP_ATTI
  as select from ZRAP110_ABOOKATT as Booking
  association to parent ZRAP110_R_TRAVELTP_ATTI as _Travel on $projection.TravelID = _Travel.TravelID
  association [1..1] to /DMO/I_Customer as _Customer on $projection.CustomerID = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier as _Carrier on $projection.CarrierID = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection as _Connection on $projection.CarrierID = _Connection.AirlineID and $projection.ConnectionID = _Connection.ConnectionID
  association [1..1] to /DMO/I_Flight as _Flight on $projection.CarrierID = _Flight.AirlineID and $projection.ConnectionID = _Flight.ConnectionID and $projection.FlightDate = _Flight.FlightDate
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on $projection.BookingStatus = _BookingStatus.BookingStatus
  association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
{
  key TRAVEL_ID as TravelID,
  key BOOKING_ID as BookingID,
  BOOKING_DATE as BookingDate,
  CUSTOMER_ID as CustomerID,
  CARRIER_ID as CarrierID,
  CONNECTION_ID as ConnectionID,
  FLIGHT_DATE as FlightDate,
  BOOKING_STATUS as BookingStatus,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  FLIGHT_PRICE as FlightPrice,
  CURRENCY_CODE as CurrencyCode,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _Travel,
  _Customer,
  _Carrier,
  _Connection,
  _Flight,
  _BookingStatus,
  _Currency
  
}
