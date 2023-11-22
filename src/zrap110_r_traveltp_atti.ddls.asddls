@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forTravel'
define root view entity ZRAP110_R_TRAVELTP_ATTI
  as select from ZRAP110_ATRAVATT as Travel
  association [0..1] to /DMO/I_Agency as _Agency on $projection.AgencyID = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer as _Customer on $projection.CustomerID = _Customer.CustomerID
  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.OverallStatus = _OverallStatus.OverallStatus
  association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
  composition [0..*] of ZRAP110_R_BOOKINGTP_ATTI as _Booking
{
  key TRAVEL_ID as TravelID,
  AGENCY_ID as AgencyID,
  CUSTOMER_ID as CustomerID,
  BEGIN_DATE as BeginDate,
  END_DATE as EndDate,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  BOOKING_FEE as BookingFee,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  TOTAL_PRICE as TotalPrice,
  CURRENCY_CODE as CurrencyCode,
  DESCRIPTION as Description,
  OVERALL_STATUS as OverallStatus,
  ATTACHMENT as Attachment,
  MIME_TYPE as MimeType,
  FILE_NAME as FileName,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _Booking,
  _Agency,
  _Customer,
  _OverallStatus,
  _Currency
  
}
