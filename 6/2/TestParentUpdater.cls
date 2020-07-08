@isTest
public with sharing class TestParentUpdater {

    @isTest static void test1() {
        List<Child__c> childs = new List<Child__c>();
        List<Parent__c> parents = new List<Parent__c>();
        for(Integer i = 0; i < 10; i++){
            parents.Add(new Parent__c(Name='parent' + i));            
        }
        insert parents;
        for(Integer i = 0; i < 10; i++){
            childs.Add(new Child__c(Name='child' + i, Parent__c = parents[i / 2].Id));
        }
        insert childs;        
        
        // Perform test

        for(Integer i = 0; i < childs.size(); i++){
            childs[i].Name = 'a' + i;
        }
        update childs;
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        Set<Id>ids = ParentUpdater.getParentsIds(childs);
        List<Parent__c> updatedParents = [
            select Id, My_Date__c
            from Parent__c
            where Id in : ids
            ];
        System.assertEquals(updatedParents.size(), 5);
        for(Integer i = 0; i < updatedParents.size(); i++){
            System.assertEquals(Date.newInstance(2017, 11, 20),
                             updatedParents[i].My_Date__c);
        }        
    }
}
