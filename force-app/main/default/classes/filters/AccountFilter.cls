public class AccountFilter extends Filter {

    public List<Account> byChangedDocument(List<Account> accounts, Map<Id, Account> oldAccounts) {
        return byChangedFields(accounts, oldAccounts, new List<String>{'CpfCnpj__c'});
    }

    public List<Account> byNotEmptyDocument(List<Account> accounts) {
        return byNotEmpty(accounts, 'CpfCnpj__c');
    }

    public List<Account> byRecordType(List<Account> accounts, Id recordTypeId) {
        return byValue(accounts, 'RecordTypeId', recordTypeId);
    }
}