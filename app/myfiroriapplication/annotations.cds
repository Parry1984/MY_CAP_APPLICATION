using CatalogService as service from '../../srv/CatalogService';


annotate CatalogService.POs with @(
    UI.SelectionFields : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value: PARTNER_GUID.BP_ID,
        },
        {
            $Type : 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.discountOnPrice',
            Label : 'Discount',
            Inline : true
        },
        {
            $Type : 'UI.DataField',
            Value: CURRENCY_code,
        },
        {
            $Type : 'UI.DataField',
            Value: LIFECYCLE_STATUS,
            Criticality : LSCriticality,
            CriticalityRepresentation : #WithoutIcon
        },
        {
            $Type : 'UI.DataField',
            Value: OVERALL_STATUS,
            Criticality : OSCriticality
        }
    ],
    UI.HeaderInfo: {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : { Label : 'Purchase Order ID', Value : PO_ID },
        Description : { Label : 'Company', Value : PARTNER_GUID.COMPANY_NAME },
        ImageUrl : 'https://www.pngmart.com/files/22/Ford-Logo-PNG-Clipart.png'
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'More Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target : '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Prices',
                    Target : '@UI.FieldGroup#Prices',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target : '@UI.FieldGroup#Status',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Items',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        },
    ],
    UI.FieldGroup #Prices : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ]
    },
    UI.FieldGroup #Status : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
                Label : 'Lifecycle Status',
                Criticality : LSCriticality,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
                Label : 'Overall Status',
                Criticality : OSCriticality,
            },
        ]
    }
);




annotate service.PurchaseOrderItems with @(
    UI : {
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PARENT_KEY_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            }
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Purchase Order Item',
            TypeNamePlural : 'Purchase Order Items',
            Title : {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS
            }
        },
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'Purchase Order Item Details',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Lineitem Information',
                        Target : '@UI.FieldGroup#LineitemData'
                    },
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Product Information',
                        Target : '@UI.FieldGroup#ProductData'
                    }
                ]
            }
        ],
        FieldGroup #LineitemData : {
            $Type : 'UI.FieldGroupType',
            Label : 'Lineitem Information',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ITEM_POS,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID_NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                }
            ]
        },
        FieldGroup #ProductData : {
            $Type : 'UI.FieldGroupType',
            Label : 'Product Information',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value :  PRODUCT_GUID.CATEGORY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.DESCRIPTION,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.PRICE,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.COUNTRY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.SUPPLIER_GUID.COMPANY_NAME,
                }
            ]
        },
    }
);


annotate service.POs with{
    PARTNER_GUID @(
        Common: {
            Text : 'PARTNER_GUID.COMPANY_NAME',
        },
        ValueList.entity : service.BusinessPartnerSet
    )
};


annotate service.PurchaseOrderItems with {
    PRODUCT_GUID @(
    Common: {
        Text : PRODUCT_GUID.DESCRIPTION,
    },
    ValueList.entity : service.ProductSet
    )
};


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME
    }]
);


annotate service.ProductSet with @(
    UI.Identification : [{
        $Type : 'UI.DataField',
        Value : DESCRIPTION
    }]
);

annotate CatalogService.POs with{
    PARTNER_GUID@(
        Common: {
            Text : PARTNER_GUID.COMPANY_NAME,
        },
        ValueList.entity : CatalogService.BusinessPartnerSet
    )
};


annotate CatalogService.PurchaseOrderItems with {
    PRODUCT_GUID@(
    Common: {
        Text : PRODUCT_GUID.DESCRIPTION,
    },
    ValueList.entity : CatalogService.ProductSet
    )
};


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME
    }]
);


@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification : [{
        $Type : 'UI.DataField',
        Value : DESCRIPTION
    }]
);


