public without sharing class Application {
    
    public static final RepositoryFactory REPOSITORY_FACTORY = new RepositoryFactory(
        new Map<SObjectType, Type>{
            Bed__c.SObjectType => BedRepository.class,
            PatientBacklog__c.SObjectType => PatientBacklogRepository.class,
            Patient__c.SObjectType => PatientRepository.class
        }
    );

    public static final FilterFactory FILTER_FACTORY = new FilterFactory(
        new Map<SObjectType, Type>{
            Bed__c.SObjectType => BedFilter.class,
            Patient__c.SObjectType => PatientFilter.class
        }
    );
}