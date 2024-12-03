public class LeadFilter extends Filter {

    public List<Lead> byChangedDocument(List<Lead> leads, Map<Id, Lead> oldLeads) {
        return byChangedFields(leads, oldLeads, new List<String>{'CpfCnpj__c'});
    }

    public List<Lead> byNotEmptyDocument(List<Lead> leads) {
        return byNotEmpty(leads, 'CpfCnpj__c');
    }

    public List<Lead> byRecordType(List<Lead> leads, Id recordTypeId) {
        return byValue(leads, 'RecordTypeId', recordTypeId);
    }
}