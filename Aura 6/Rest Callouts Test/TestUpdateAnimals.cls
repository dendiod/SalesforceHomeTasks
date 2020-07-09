@isTest
public with sharing class TestUpdateAnimals {
    @isTest static void testInsert() {
        List<Animal__c> animals = new List<Animal__c>();
        for(Integer i = 0; i < 1; i++) {
            animals.add(new Animal__c(Name = 'a' + i, My_Id__c = String.valueOf(Math.mod(i, 2)+ 1)));
        }
        Test.startTest(); 
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);       
        insert animals;
        Test.stopTest();

        Set<Id> ids = new Set<Id>();

        for(Animal__c a : animals) {
            ids.add(a.Id);
        }
        System.debug(animals);
        animals = [Select id, name, My_Id__c from Animal__c where id in :ids];
        System.debug(animals);

        List<String>names = new List<String>{'chicken', 'bear'};
        for(Integer i = 0; i < animals.size(); i++) {
            System.assertEquals(names[Math.mod(i, 2)], animals[i].Name);
        }
    }

    @isTest static void testUpdate() {
        List<Animal__c> animals = new List<Animal__c>();
        for(Integer i = 0; i < 1; i++) {
            animals.add(new Animal__c(Name = 'a' + i, My_Id__c = '7'));
        }
        Test.startTest();
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        insert animals;
        Test.stopTest();
        Set<Id> ids = new Set<Id>();

        for(Animal__c a : animals) {
            ids.add(a.Id);
        }
        
        animals = [Select id, name from Animal__c where id in :ids];
        
        for(Integer i = 0; i < animals.size(); i++) {
            animals[i].My_Id__c = '1';
        }
        
        update animals;
        
        animals = [Select id, name from Animal__c where id in :ids];
       
        for(Integer i = 0; i < animals.size(); i++) {
            System.assertEquals('chicken', animals[i].Name);
        }
    }
}
