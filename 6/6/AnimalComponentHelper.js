({
    getData : function(component) {
        var expname = component.get("v.myText");
        var action = component.get("c.getAnimals");
        action.setParams({ record_id : expname  });
        action.setCallback(this,function (response) { 
            var state = response.getState();
            if (state === "SUCCESS") {
        	    component.set('v.mydata', response.getReturnValue());
            }
            else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
