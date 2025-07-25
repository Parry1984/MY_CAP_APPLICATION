namespace com.tcs.sd.soa.db;
using { com.tcs.sd.soa.common as common } from './reuse';
using { Currency, cuid } from '@sap/cds/common';
 
 
context master {
    entity businesspartner {
        key NODE_KEY : common.Guid;
        BP_ROLE : String(2);
        EMAIL : String(255);
        MOBILE : common.Guid;
        FAX : common.Guid;
        WEB : String(105);
        ADDRESS_GUID : Association to address;
        BP_ID : String(32) @(title : '{i18n>BP_ID}');
        COMPANY_NAME : String(255) @(title : '{i18n>COMPANY_NAME}');
    }
 
    entity address {
        key NODE_KEY : common.Guid;
        CITY : common.str64;
        POSTAL : String(8);
        STREET : common.str64;
        LANDMARK : String(128);
        COUNTRY : common.str64 @(title : '{i18n>COUNTRY}');
        ADDRESS_TYPE : common.str64;
        VAL_START : Date;
        VAL_END : Date;
        LATITUDE : Decimal;
        LONGITUDE : Decimal;
        businesspartner : Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }
 
    entity product {
        key NODE_KEY : common.Guid;
        PRODUCT_ID : common.str64 @(title : '{i18n>PRODUCT_ID}');
        TYPE_CODE : String(2);
        CATEGORY : common.str64 @(title : '{i18n>CATEGORY}');
        DESCRIPTION : String(255) @(title : '{i18n>DESCRIPTION}');
        SUPPLIER_GUID : Association to master.businesspartner;
        TAX_TARIF : Integer;
        MEASURE_UNIT : String(2);
        WEIGHT_MEASURE : Decimal(5,2);
        WEIGHT_UNIT : String(2);
        CURRENCY_CODE : String(4);
        PRICE : Decimal(10, 2) @(title : '{i18n>PRICE}');
        WIDTH : Decimal(5, 2);
        HEIGHT : Decimal(5, 2);
        DIM_UNIT : String(2);
    }
 
    entity employees : cuid  {
        nameFirst : common.str64;
        nameLast : common.str64;
        nameMiddle : common.str64;
        nameInitials : common.str64;
        sex : common.Gender;
        language : String(2);
        phoneNumber : common.phoneNumber;
        email : common.Email;
        loginName : String(12);
        Currency : Currency;
        salary : common.AmountT;
        accountNumber : String(16);
        bankId : String(12);
        bankName : String(64);
    }
}
 
context transaction {
    entity purchaseorder : common.Amount {
        key NODE_KEY : common.Guid;
        PO_ID : String(40) @(title : '{i18n>PO_ID}');
        PARTNER_GUID : Association to master.businesspartner  @(title : '{i18n>PARTNER_GUID}');
        LIFECYCLE_STATUS : String(1) @(title : '{i18n>LIFECYCLE_STATUS}');
        OVERALL_STATUS : String(1) @(title : '{i18n>OVERALL_STATUS}');
        // Association - Two entities are independent on each other.
        // Composition - Two entitess are dependent on each other.
        Items: Composition of many poitems on Items.PARENT_KEY =$self;
    }
 
    entity poitems : common.Amount {
        key NODE_KEY : common.Guid;
        PARENT_KEY : Association to purchaseorder @(title : '{i18n>PARENT_KEY}');
        PO_ITEM_POS : Integer @(title : '{i18n>PO_ITEM_POS}');
        PRODUCT_GUID : Association to master.product @(title : '{i18n>PRODUCT_GUID}');
    }
}