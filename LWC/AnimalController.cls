public with sharing class AnimalController {
    @AuraEnabled(cacheable=true)
    public static List<Animal__c> searchAnimals(String searchTerm) {
        searchTerm = searchTerm.deleteWhitespace();
        List<String>tempIds;
        if(searchTerm == '') {
            tempIds = new List<String>();
        }
        else {
            tempIds = searchTerm.split(','); 
        }
             
        Set<String> ids = new Set<String>();
        ids.addAll(tempIds);    
        List<Animal__c> animals = [
            SELECT Id, Name, My_Id__c, Eats__c, Says__c
            FROM Animal__c WHERE My_Id__c IN :ids
            WITH SECURITY_ENFORCED
        ];

        getHerokuIds(ids, animals);
        makeRestCallouts(ids, animals);
        
        return animals;
    }

    private static Set<String> getHerokuIds(Set<String> ids, List<Animal__c> animals) {
        Set<String> idsInOrg = new Set<String>();
        for(Animal__c a : animals) {
            idsInOrg.add(a.My_Id__c);
        }
        ids.removeAll(idsInOrg);
        return ids;
    }

    private static List<Animal__c> makeRestCallouts(Set<String> ids, List<Animal__c> animals) {
        Http http = new Http();
        for(String myId : ids) {           
            HttpRequest request = new HttpRequest();        
            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + myId);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            Map<String, Animal> result = (Map<String, Animal>) JSON.deserialize(response.getBody(), Map<String, Animal>.class);
		    Animal a = result.get('animal');
            
            animals.add(new Animal__c(Name = a.name, My_Id__c = a.id + ' (heroku)', Says__c = a.says, Eats__c = a.eats));
        }
        return animals;
    }
}