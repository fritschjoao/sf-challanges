public class AccountDocumentValidator {

    private CpfValidator cpfValidator;
    private CnpjValidator cnpjValidator;
    private AccountFilter accountFilter;

    public AccountDocumentValidator() {
        this.cpfValidator = new CpfValidator();
        this.cnpjValidator = new CnpjValidator();
        
        this.accountFilter = new AccountFilter();
    }

    public void validate(List<Account> accounts) {
        List<Account> filteredAccounts = this.accountFilter.byNotEmptyDocument(accounts);

        if(filteredAccounts.isEmpty()) {
            return;
        }

        validateIndividualDocument(filteredAccounts);
        validateJuridicalDocument(filteredAccounts);
    }

    private void validateIndividualDocument(List<Account> accounts) {
        List<Account> individualAccounts = this.accountFilter.byRecordType(filteredAccounts, SObjects.getRecordTypeId('Account', 'IndividualPerson'));
        
        validateDocument(individualAccounts);
    }

    private void validateJuridicalDocument(List<Account> accounts) {
        List<Account> juridicalAccounts = this.accountFilter.byRecordType(filteredAccounts, SObjects.getRecordTypeId('Account', 'JuridicalPerson'));

        validateDocument(juridicalAccounts);
    }

    private void validateDocument(List<Account> accounts) {
        for(Account account : accounts) {
            if(!this.cnpjValidator.isValid(account.CpfCnpj__c)) {
                account.addError('Invalid Document');
            }
        }
    }
}