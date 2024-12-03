@isTest
public class AccountFixtureFactory {

    private static Map<String, Schema.RecordTypeInfo> recordTypes = Account.SObjectType.getDescribe().getRecordTypeInfosByDeveloperName();

    public static Account createIndividualPersonAccount(String name, String document) {
        return save(newIndividualPersonAccount(name, document));
    }

    public static Account createJuridicalPersonAccount(String name, String document) {
        return save(newJuridicalPersonAccount(name, document));
    }

    public static Account createAccount(String name, String document, Id recordTypeId) {
        return save(newAccount(name, document, recordTypeId));
    }

    public static Account newIndividualPersonAccount(String name, String document) {
        return newAccount(Name = name, document, recordTypes.get('IndividualPerson').getRecordTypeId());
    }

    public static Account newJuridicalPersonAccount(String name, String document) {
        return newAccount(Name = name, document, recordTypes.get('JuridicalPerson').getRecordTypeId());
    }
    
    public static Account newAccount(String name, String document, Id recordTypeId) {
        return new Account(Name = name, CpfCnpj__c = document, RecordTypeId = recordTypeId);
    }

    public static Account save(Account account) {
        upsert account;
        return account;
    }
}