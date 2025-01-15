public inherited sharing class BedRepository extends Repository {

    public override sObjectType getSObjectType() {
        return Bed__c.sObjectType;
    }

    public List<Bed__c> findAvailableByCategory(List<String> categories) {
        return [
            SELECT Id, Category__c, Status__c 
            FROM Bed__c 
            WHERE Status__c =: Constants.AVAILABLE AND Category__c IN: categories
        ];
    }

    public List<Bed__c> save(List<Bed__c> beds) {
        return super.save(beds);
    }
}