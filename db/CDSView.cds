namespace com.tcs.sd.soa.cds;
 
using { com.tcs.sd.soa.db.master, com.tcs.sd.soa.db.transaction } from './datamodel';
 
context CDSView {
    define view![POWorklist] as
        select from transaction.purchaseorder{
            key PO_ID as ![PurchaseOrderId],
            key Items.PO_ITEM_POS as ![Item],
            PARTNER_GUID.BP_ID as ![PartnerId],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            CURRENCY as ![CurrencyCode],
            OVERALL_STATUS as ![OverallStatus],
            Items.PRODUCT_GUID.PRODUCT_ID as ![ProductId],
            Items.PRODUCT_GUID.DESCRIPTION as ![Description],
            PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]
        };
 
    define view![ItemView] as
        select from transaction.poitems{
            PARENT_KEY.PARTNER_GUID.NODE_KEY as ![CustomerId],
            PRODUCT_GUID.NODE_KEY as ![ProductId],
            CURRENCY as ![CurrencyCode],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as ![OverallStatus]
        };
 
        define view ProductView as
            select from master.product
//      MIXIN is a keyword to define loose coupling
        mixin {
            PO_ORDER : Association[*] to ItemView on PO_ORDER.ProductId = $projection.ProductId
        } into {
            NODE_KEY as ![ProductId],
            DESCRIPTION as ![Description],
            CATEGORY as ![Category],
            PRICE as ![Price],
            SUPPLIER_GUID.BP_ID as ![SupplierId],
            SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
            PO_ORDER as ![To_Items]
        };
}
 