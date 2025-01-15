public with sharing class PatientTriggerHandler extends TriggerHandler {

    private List<Patient__c> newPatients;
    private Map<Id, Patient__c> oldPatients;

    private BedPatientEnricher bedPatientEnricher;

    public PatientTriggerHandler() {
        this((List<Patient__c>)Trigger.new, (Map<Id, Patient__c>)Trigger.oldMap);
    }

    public PatientTriggerHandler(List<Patient__c> newPatients, Map<Id, Patient__c> oldPatients) {
        this.newPatients = newPatients;
        this.oldPatients = oldPatients;

        this.bedPatientEnricher = new BedPatientEnricher();
    }

    public override void afterInsert() {
        allocateBeds();
    }

    public override void afterUpdate() {
        allocateBeds();
    }

    private void allocateBeds() {
        this.bedPatientEnricher.allocateBeds(this.newPatients);
    }
}