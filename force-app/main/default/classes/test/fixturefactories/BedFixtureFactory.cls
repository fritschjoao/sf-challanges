@isTest
public class BedFixtureFactory {

    public static Bed__c newAvailableBed(String category) {
        return newBed(Constants.AVAILABLE, category);
    }
    
    public static Bed__c newBed(String status, String category) {
        return new Bed__c(Id = MockerUtils.generateId(Bed__c.SObjectType), Status__c = status, Category__c = category);
    }
}