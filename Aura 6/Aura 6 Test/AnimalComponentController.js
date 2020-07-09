({
    doInit : function (component, event, helper) {
        var actions = [{ label: 'Show details', name: 'show_details' }];

        component.set('v.mycolumns', [
            { type: 'action', typeAttributes: { rowActions: actions } },
            { label: 'Animal Name', fieldName: 'Name', type: 'text'},
            { label: 'My_Id', fieldName: 'My_Id__c', type: 'text'},
            { label: 'Eats', fieldName: 'Eats__c', type: 'text'},
            { label: 'Says', fieldName: 'Says__c', type: 'text'}            
        ]);
        helper.getData(component);        
    },

    handleRowAction : function(cmp,event,helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
      // navigate to sObject detail page     
         var navEvt = $A.get("e.force:navigateToSObject");
         navEvt.setParams({
             "recordId": row.Id,
             "slideDevName": "detail"
         });
         navEvt.fire();
     }
})
