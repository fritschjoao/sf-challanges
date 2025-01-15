public inherited sharing class PatientRepository extends Repository {

    public override sObjectType getSObjectType() {
        return Patient__c.sObjectType;
    }

    public List<Patient__c> save(List<Patient__c> patients) {
        return super.save(patients);
    }
}