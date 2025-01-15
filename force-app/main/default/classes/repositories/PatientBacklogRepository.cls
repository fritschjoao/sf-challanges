public inherited sharing class PatientBacklogRepository extends Repository {

    public override sObjectType getSObjectType() {
        return PatientBacklog__c.sObjectType;
    }

    public List<PatientBacklog__c> save(List<PatientBacklog__c> patientBacklogs) {
        return super.save(patientBacklogs);
    }
}