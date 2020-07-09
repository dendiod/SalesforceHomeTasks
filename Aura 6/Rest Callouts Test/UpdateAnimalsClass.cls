public with sharing class UpdateAnimalsClass {
    @future(callout=true)
    public static void checkForUpdate(Set<Id> ids) {        
        List<Animal__c> animals = [SELECT Name, My_Id__c FROM Animal__c WHERE Id in :ids AND My_Id__c != NULL];
          
        for(Animal__c a : animals) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String myId = a.My_Id__c;        
            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + myId);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            Map<String, Animal> result = (Map<String, Animal>) JSON.deserialize(response.getBody(), Map<String, Animal>.class);
		    Animal animal = result.get('animal');
            
            a.Name = String.valueOf(animal.name);    
        }
        update animals;
    }
}
