namespace com.tcs.sd.soa.common;
using { Currency } from '@sap/cds/common';
 
 
type Gender : String(1) enum{
    male = 'M';
    female = 'F';
    undisclosed = 'U'
};
 
type AmountT : Decimal(10,2)@(
    Semantics.amount.currencyCode : 'CURRENCY',
    sap.unit : 'CURRENCY'
);
 
aspect Amount : {
    CURRENCY : Currency;
    GROSS_AMOUNT : AmountT @(title : '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT : AmountT @(title : '{i18n>NET_AMOUNT}');
    TAX_AMOUNT : AmountT @(title : '{i18n>TAX_AMOUNT}');
}
 
type Guid : String(32);
type str64 : String(64);
type phoneNumber : String(30);
type Email : String(255);
 

    