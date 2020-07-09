trigger UpdateAnimalsTrigger on Animal__c (after insert, after update) {    
    if(System.IsBatch() == false && System.isFuture() == false){ 
        UpdateAnimalsClass.checkForUpdate(Trigger.newMap.keySet());
    }    
}