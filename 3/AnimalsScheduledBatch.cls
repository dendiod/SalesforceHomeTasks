global class AnimalsScheduledBatch implements Database.Batchable<sObject>, Schedulable{
	global void execute(SchedulableContext ctx) {
        Database.executeBatch(new AnimalsScheduledBatch());
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Name From Animal__c'
        );
    }
    global void execute(Database.BatchableContext bc, List<Animal__c> records){
        delete records;
    }
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}