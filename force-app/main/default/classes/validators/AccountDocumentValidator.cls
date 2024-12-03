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

        List<Account> individualAccounts = this.accountFilter.byRecordType(filteredAccounts, SObjects.getRecordTypeId('Account', 'IndividualPerson'));
        validateIndividualDocument(individualAccounts);

        List<Account> juridicalAccounts = this.accountFilter.byRecordType(filteredAccounts, SObjects.getRecordTypeId('Account', 'JuridicalPerson'));
        validateJuridicalDocument(juridicalAccounts);
    }

    private void validateIndividualDocument(List<Account> accounts) {
        for(Account account : accounts) {
            if(!this.cpfValidator.isValid(account.CpfCnpj__c)) {
                account.addError('Invalid Document');
            }
        }
    }

    private void validateJuridicalDocument(List<Account> accounts) {
        for(Account account : accounts) {
            if(!this.cnpjValidator.isValid(account.CpfCnpj__c)) {
                account.addError('Invalid Document');
            }
        }
    }
}