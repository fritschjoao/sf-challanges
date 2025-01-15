@isTest
public class PatientFixtureFactory {

    public static Patient__c newWaitingPatient(String priority) {
        return newPatient('Test Patient', priority, Constants.WAITING);
    }
    
    public static Patient__c newPatient(String name, String priority, String admissionStatus) {
        return new Patient__c(Id = MockerUtils.generateId(Patient__c.SObjectType), Name = name, Priority__c = priority, AdmissionStatus__c = admissionStatus);
    }
}