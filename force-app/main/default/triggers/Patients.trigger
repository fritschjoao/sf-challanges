trigger Patients on Patient__c (after insert, after update) { 
    // if(Trigger.isAfter()) { 
    //     PatientBedAllocationHandler.allocateBeds(Trigger.new); 
    // } 

    new PatientTriggerHandler().run();
}