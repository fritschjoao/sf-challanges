public with sharing class BedPatientEnricher {

    // Filters
    private PatientFilter patientFilter;
    private BedFilter bedFilter;

    // Repositories
    private PatientRepository patientRepository;
    private BedRepository bedRepository;
    private PatientBacklogRepository patientBacklogRepository;

    public BedPatientEnricher() {
        this.patientFilter = (PatientFilter)Application.FILTER_FACTORY.newInstance(Patient__c.SObjectType);
        this.bedFilter = (BedFilter)Application.FILTER_FACTORY.newInstance(Bed__c.SObjectType);

        this.patientRepository = (PatientRepository)Application.REPOSITORY_FACTORY.newInstance(Patient__c.SObjectType);
        this.bedRepository = (BedRepository)Application.REPOSITORY_FACTORY.newInstance(Bed__c.SObjectType);
        this.patientBacklogRepository = (PatientBacklogRepository)Application.REPOSITORY_FACTORY.newInstance(PatientBacklog__c.SObjectType);
    }

    public void allocateBeds(List<Patient__c> patients) {
        List<Patient__c> waitingPatients = this.patientFilter.byAdmissionStatus(patients, Constants.WAITING);

        if(waitingPatients.isEmpty()) {
            return;
        }

        List<String> priorities = Lists.pullField(waitingPatients, Constants.PRIORITY_FIELD);
        List<Bed__c> availableBeds = this.bedRepository.findAvailableByCategory(priorities);

        if(availableBeds.isEmpty()) {
            return;
        }
        
        Map<String, List<Bed__c>> availableBedsByCategory = this.bedFilter.groupByCategory(availableBeds);
        this.allocateBeds(waitingPatients, availableBedsByCategory);
    }

    private void allocateBeds(List<Patient__c> waitingPatients, Map<String, List<Bed__c>> availableBedsByCategory) {
        List<Patient__c> patientsAdmitted = new List<Patient__c>();
        List<Bed__c> bedsOccupied = new List<Bed__c>();
        List<PatientBacklog__c> backlog = new List<PatientBacklog__c>();
        Bed__c allocatedBed;

        for(Patient__c waitingPatient : waitingPatients) {
            allocatedBed = getAvailableBed(waitingPatient, availableBedsByCategory);

            if(allocatedBed != null) {
                waitingPatient.AssignedBed__c = allocatedBed.Id;
                waitingPatient.AdmissionStatus__c = Constants.ADMITTED;
                patientsAdmitted.add(waitingPatient);

                allocatedBed.Status__c = Constants.OCCUPIED;
                bedsOccupied.add(allocatedBed);
            } else {
                backlog.add(new PatientBacklog__c(Patient__c = waitingPatient.Id, Status__c = Constants.WAITING_FOR_BED));
            }
        }

        this.patientRepository.save(patientsAdmitted);
        this.bedRepository.save(bedsOccupied);
        this.patientBacklogRepository.save(backlog);
    }

    private Bed__c getAvailableBed(Patient__c patient, Map<String, List<Bed__c>> availableBedsByCategory) {
        Bed__c availableBed;
        String priority = patient.Priority__c;

        if(availableBedsByCategory.containsKey(priority)) {
            List<Bed__c> beds = availableBedsByCategory.get(priority);

            if(!beds.isEmpty()) {
                availableBed = beds.remove(0);
            }
        }

        return availableBed;
    }
}