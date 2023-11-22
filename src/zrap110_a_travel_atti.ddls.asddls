@EndUserText.label: 'Parameter for Creating Travel+Booking'
define abstract entity ZRAP110_A_TRAVEL_ATTI
{
  travel_id : /DMO/TRAVEL_ID;
  agency_id : /DMO/AGENCY_ID;
  customer_id : /DMO/CUSTOMER_ID;
  overall_status : /DMO/OVERALL_STATUS;
  description : /DMO/DESCRIPTION;
  @Semantics.amount.currencyCode: 'currency_code'
  total_price : /DMO/TOTAL_PRICE;
  currency_code : /DMO/CURRENCY_CODE;
  begin_date : /DMO/BEGIN_DATE;
  end_date : /DMO/END_DATE;
  email_address : /DMO/EMAIL_ADDRESS;
  
}
