public with sharing class UpdateAnimalsClass {
    @future(callout=true)
    public static void checkForUpdate(Set<Id> ids) {
        List<Animal__c> animals = [SELECT Name, My_Id__c FROM Animal__c WHERE Id in :ids AND My_Id__c != NULL];
        for(Animal__c a : animals) {
            String myId = a.My_Id__c;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + myId);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
		    Map<String, Object> animal = (Map<String, Object>) result.get('animal');

            a.Name = animal.get('name').toString();    
            
            System.debug(a.Name);
        }
        update animals;
    }
}
