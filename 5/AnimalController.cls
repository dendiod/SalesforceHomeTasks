public with sharing class AnimalController {
    // STERN LECTURE ABOUT WHAT'S MISSING HERE COMING SOON
    @AuraEnabled
    public static List<Animal__c> getAnimals(String record_id) {
        return [SELECT Id, Name, My_Id__c, Eats__c, Says__c 
                FROM Animal__c WHERE My_Id__c != NULL AND My_Id__c = :record_id];
    }
}
