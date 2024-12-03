public with sharing class LeadTriggerHandler extends TriggerHandler {

    private List<Lead> newLeads;
    private Map<Id, Lead> oldLeads;
    private LeadFilter leadfilter;
    private LeadDocumentValidator leadDocumentValidator;

    public LeadTriggerHandler() {
        this((List<Lead>)Trigger.new, (Map<Id, Lead>)Trigger.oldMap);
    }

    public LeadTriggerHandler(List<Lead> newLeads, Map<Id, Lead> oldLeads) {
        this.newLeads = newLeads;
        this.oldLeads = oldLeads;

        this.leadfilter = new LeadFilter();
        this.leadDocumentValidator = new LeadDocumentValidator();
    }

    public override void beforeInsert() {
        validateDocument();
    }

    public override void beforeUpdate() {
        validateChangedDocument();
    }

    private void validateDocument() {
        validateDocument(this.newLeads);
    }

    private void validateChangedDocument() {
        List<Lead> changedLeads = this.leadfilter.byChangedDocument(this.newLeads, this.oldLeads);

        validateDocument(changedLeads);
    }

    private void validateDocument(List<Lead> leads) {
        this.leadDocumentValidator.validate(leads);
    }
}