public class LeadDocumentValidator {

    private CpfValidator cpfValidator;
    private CnpjValidator cnpjValidator;
    private LeadFilter leadFilter;

    public LeadDocumentValidator() {
        this.cpfValidator = new CpfValidator();
        this.cnpjValidator = new CnpjValidator();

        this.leadFilter = new LeadFilter();
    }

    public void validate(List<Lead> leads) {
        List<Lead> filteredLeads = this.leadFilter.byNotEmptyDocument(leads);

        List<Lead> individualLeads = this.leadFilter.byRecordType(filteredLeads, SObjects.getRecordTypeId('Lead', 'IndividualPerson'));
        validateIndividualDocument(individualLeads);

        List<Lead> juridicalLeads = this.leadFilter.byRecordType(filteredLeads, SObjects.getRecordTypeId('Lead', 'JuridicalPerson'));
        validateJuridicalDocument(juridicalLeads);
    }

    private void validateIndividualDocument(List<Lead> leads) {
        for(Lead lead : leads) {
            if(!this.cpfValidator.isValid(lead.CpfCnpj__c)) {
                lead.addError('Invalid Document');
            }
        }
    }

    private void validateJuridicalDocument(List<Lead> leads) {
        for(Lead lead : leads) {
            if(!this.cnpjValidator.isValid(lead.CpfCnpj__c)) {
                lead.addError('Invalid Document');
            }
        }
    }
}