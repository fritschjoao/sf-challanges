@isTest
public class LeadFixtureFactory {

    private static Map<String, Schema.RecordTypeInfo> recordTypes = Lead.SObjectType.getDescribe().getRecordTypeInfosByDeveloperName();

    public static Lead createIndividualPersonLead(String name, String document) {
        return save(newIndividualPersonLead(name, document));
    }

    public static Lead createJuridicalPersonLead(String name, String document) {
        return save(newJuridicalPersonLead(name, document));
    }

    public static Lead createLead(String name, String document, Id recordTypeId) {
        return save(newLead(name, document, recordTypeId));
    }

    public static Lead newIndividualPersonLead(String name, String document) {
        return newLead(Name = name, document, recordTypes.get('IndividualPerson').getRecordTypeId());
    }

    public static Lead newJuridicalPersonLead(String name, String document) {
        return newLead(Name = name, document, recordTypes.get('JuridicalPerson').getRecordTypeId());
    }
    
    public static Lead newLead(String name, String document, Id recordTypeId) {
        return new Lead(LastName = name, CpfCnpj__c = document, RecordTypeId = recordTypeId);
    }

    public static Lead save(Lead lead) {
        upsert lead;
        return lead;
    }
}