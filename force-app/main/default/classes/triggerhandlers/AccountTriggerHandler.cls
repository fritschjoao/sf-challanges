public with sharing class AccountTriggerHandler extends TriggerHandler {

    private List<Account> newAccounts;
    private Map<Id, Account> oldAccounts;
    private AccountFilter accountFilter;
    private AccountDocumentValidator accountDocumentValidator;

    public AccountTriggerHandler() {
        this((List<Account>)Trigger.new, (Map<Id, Account>)Trigger.oldMap);
    }

    public AccountTriggerHandler(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;

        this.accountFilter = new AccountFilter();
        this.accountDocumentValidator = new AccountDocumentValidator();
    }

    public override void beforeInsert() {
        validateDocument();
    }

    public override void beforeUpdate() {
        validateChangedDocument();
    }

    private void validateDocument() {
        validateDocument(this.newAccounts);
    }

    private void validateChangedDocument() {
        List<Account> changedAccounts = this.accountFilter.byChangedDocument(this.newAccounts, this.oldAccounts);

        validateDocument(changedAccounts);
    }

    private void validateDocument(List<Account> accounts) {
        this.accountDocumentValidator.validate(accounts);
    }
}