@isTest
public class PatientTest {

    @isTest
    static void shouldAllocateBedToParticipant() {
        //Create Data
        Bed__c availableBed = BedFixtureFactory.newAvailableBed(Constants.HIGH);
        Patient__c waitingPatient = PatientFixtureFactory.newWaitingPatient(Constants.HIGH);

        // Start Mocking
        Mocker mocker = Mocker.startStubbing();

        // Given - Create Mocks
        PatientRepository patientRepository = (PatientRepository)mocker.mock(PatientRepository.class);
        BedRepository bedRepository = (BedRepository)mocker.mock(BedRepository.class);
        PatientBacklogRepository patientBacklogRepository = (PatientBacklogRepository)mocker.mock(PatientBacklogRepository.class);
        Database database = (Database)mocker.mock(Database.class);

        // Given - Configure Mock Responses
        mocker.when( bedRepository.getSObjectType() ).thenReturn( Bed__c.sObjectType );
        mocker.when( bedRepository.findAvailableByCategory( new List<String>{Constants.HIGH}) ).thenReturn( new List<Bed__c>{availableBed} );

        //Stop Mocking
        mocker.stopStubbing();

        // Given - Inject Mocks
        Application.REPOSITORY_FACTORY.setMock(patientRepository);
        Application.REPOSITORY_FACTORY.setMock(bedRepository);
        Application.REPOSITORY_FACTORY.setMock(patientBacklogRepository);

        // When
        Test.startTest();
        new PatientTriggerHandler(new List<Patient__c>{waitingPatient}, null).afterInsert();
        Test.stopTest();

        // Then
        Assert.areEqual(availableBed.Id, waitingPatient.AssignedBed__c, 'Should assign bed to patient');
    }
}