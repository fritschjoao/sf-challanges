public class PatientBedAllocationHandler {

    public static void allocateBeds(List<Patient__c> listPatient) {
        List<Patient__c> patientList = new List<Patient__c>();
        List<Bed__c> bedsToUpdate = new List<Bed__c>();
        List<PatientBacklog__c> backlog = new List<PatientBacklog__c>();

        if (!listPatient.isEmpty()) {
            for (Patient__c p : listPatient) {
                if (p.AdmissionStatus__c == 'Waiting') {
                    String priority = p.Priority__c;
                    Map<String, List<Bed__c>> availableBeds = getAvailableBedsByCategory(priority);
                    Bed__c allocatedBed;

                    if (availableBeds.containsKey(priority)) {
                        List<Bed__c> beds = availableBeds.get(priority);
                        if (!beds.isEmpty()) {
                            allocatedBed = beds.remove(0);
                        }
                    }

                    if (allocatedBed != null) {
                        patientList.add(
                            new Patient__c(
                                Id = p.Id,
                                AssignedBed__c = allocatedBed.Id,
                                AdmissionStatus__c = 'Admitted'
                            )
                        );
                        allocatedBed.Status__c = 'Occupied';
                        bedsToUpdate.add(allocatedBed);
                    } else {
                        backlog.add(
                            new PatientBacklog__c(
                                Patient__c = p.Id,
                                Status__c = 'Waiting For Bed'
                            )
                        );
                    }
                }
            }
            update patientList;
            update bedsToUpdate;
            update backlog;
        }
    }

    private static Map<String, List<Bed__c>> getAvailableBedsByCategory(String category) {
        List<Bed__c> bedLst = [
            SELECT Id, Category__c, Status__c 
            FROM Bed__c 
            WHERE Status__c = 'Available' AND Category__c = :category
        ];
        
        Map<String, List<Bed__c>> bedMap = new Map<String, List<Bed__c>>();
        
        if (!bedLst.isEmpty()) {
            for (Bed__c bed : bedLst) {
                if (bedMap.get(bed.Category__c) == null) {
                    bedMap.put(bed.Category__c, new List<Bed__c>{bed});
                } else {
                    bedMap.get(bed.Category__c).add(bed);
                }
            }
        }
        return bedMap;
    }
}
