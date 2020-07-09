({
    doInit : function (component, event, helper) {
        var id_in_text = component.get("v.myText");
        var action = component.get("c.getAnimals");
        action.setParams({ record_id : id_in_text  });
        action.setCallback(this,function (response) { 
            var state = response.getState();
            if (state === "SUCCESS") {
        	    var animalItems = response.getReturnValue();
                component.set("v.items", animalItems);
            }
            else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
