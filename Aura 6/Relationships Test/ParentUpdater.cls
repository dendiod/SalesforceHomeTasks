public class ParentUpdater {
    public static void updateParents(List<Child__c> childs) {
        Set<Id> parentIdeis = getParentsIds(childs);
        Map<Id, Parent__c> parents = querryParents(parentIdeis);
        executeUpdate(parents);
    }
    public static Set<Id> getParentsIds(List<Child__c> childs) {
        Set<Id> result = new Set<Id>();
        for(Child__c curChild : childs) {
           if(curChild.Parent__c != null) {
              result.add(curChild.Parent__c);
            }
        }
        return result;
    }
    private static Map<Id, Parent__c> querryParents(Set<Id> ids) {
        return new Map<Id, Parent__c>([
            select Id, My_Date__c
            from Parent__c
            where Id in : ids
            ]);
    }
    private static void executeUpdate(Map<Id, Parent__c> parents) {
        List<Parent__c> parentsToUpdate = new List<Parent__c>();
        for (Id parentId : parents.keySet()) {
            Parent__c curParent = parents.get(parentId);
            curParent.My_Date__c = Date.newInstance(2017, 11, 20);
            parentsToUpdate.add(curParent);
         }
        if(parentsToUpdate.size() > 0) {
            update parentsToUpdate;
        }
    }
}