global class LeadsScheduledBatch implements Database.Batchable<sObject>, Schedulable{
	global void execute(SchedulableContext ctx) {
        Database.executeBatch(new LeadsScheduledBatch());
    }
	
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Domain__c, Email From Lead WHERE Email != NULL'
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> records){
        for(Lead l : records) {
			l.Domain__c = l.Email.substring(l.Email.lastIndexOf('@') + 1);
		}
		update records;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}