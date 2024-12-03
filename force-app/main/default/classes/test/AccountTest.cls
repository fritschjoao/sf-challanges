@isTest
public class AccountTest {

    @isTest
    public static void shouldCreateIndividualAccountWhenCpfWithLessThan11Digits() {
        String expectedError;
        
        try {
            Account account = AccountFixtureFactory.createIndividualPersonAccount('Individual Test', '697949286');
        } catch(Exception e) {
            expectedError = e.getMessage();
        }

        Assert.isTrue(expectedError.contains('Invalid Document'), 'Should be an error');
    }

    @isTest
    public static void shouldCreateJuridicalAccountWhenCnpjWithLessThan14Digits() {
        String expectedError;
        
        try {
            Account account = AccountFixtureFactory.createJuridicalPersonAccount('Juridical Test', '8456062400015');
        } catch(Exception e) {
            expectedError = e.getMessage();
        }

        Assert.isTrue(expectedError.contains('Invalid Document'), 'Should be an error');
    }
}