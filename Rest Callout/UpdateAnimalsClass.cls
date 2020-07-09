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
            Map<String, String> result = (Map<String, String>) JSON.deserialize(response.getBody(), Map<String, String>.class);
		    Map<String, String> animal = (Map<String, String>) result.get('animal');

            a.Name = animal.get('name').toString();    
            
            System.debug(a.Name);
        }
        update animals;
    }
}
