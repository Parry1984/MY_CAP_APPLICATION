sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'myfiroriapplication/test/integration/FirstJourney',
		'myfiroriapplication/test/integration/pages/POsList',
		'myfiroriapplication/test/integration/pages/POsObjectPage',
		'myfiroriapplication/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('myfiroriapplication') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);