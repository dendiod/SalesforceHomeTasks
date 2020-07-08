trigger ChildUpdateTrigger on Child__c (before update) {
    ParentUpdater.updateParents(Trigger.New);
}