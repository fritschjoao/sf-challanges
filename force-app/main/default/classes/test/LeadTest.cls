@isTest
public class LeadTest {

    @isTest
    public static void shouldCreateIndividualLeadWhenCpfWithLessThan11Digits() {
        String expectedError;
        
        try {
            Lead lead = LeadFixtureFactory.createIndividualPersonLead('Individual Test', '697949286');
        } catch(Exception e) {
            expectedError = e.getMessage();
        }

        Assert.isTrue(expectedError.contains('Invalid Document'), 'Should be an error');
    }

    @isTest
    public static void shouldCreateJuridicalLeadWhenCnpjWithLessThan14Digits() {
        String expectedError;
        
        try {
            Lead lead = LeadFixtureFactory.createJuridicalPersonLead('Juridical Test', '8456062400015');
        } catch(Exception e) {
            expectedError = e.getMessage();
        }

        Assert.isTrue(expectedError.contains('Invalid Document'), 'Should be an error');
    }
}