public class PatientFilter extends Filter {

    public List<Patient__c> byAdmissionStatus(List<Patient__c> patients, String status) {
        return byValue(patients, 'AdmissionStatus__c', status);
    }
}