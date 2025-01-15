public without sharing class RepositoryFactory {
    
    private Map<SObjectType, Type> classBySObjectType;
    private Map<SObjectType, Repository> repositoryBySObjectType;

    public RepositoryFactory(Map<SObjectType, Type> classBySObjectType) {
        this.classBySObjectType = classBySObjectType;
        this.repositoryBySObjectType = new Map<SObjectType, Repository>();
    }

    public Repository newInstance(SObjectType sObjectType) {
        if(this.repositoryBySObjectType.containsKey(sObjectType)) {
            return this.repositoryBySObjectType.get(sObjectType);
        }

        Type repositoryClass = this.classBySObjectType.get(sObjectType);

        if(repositoryClass == null) {
            throw new RepositoryFactoryException('Repository class not found for SObjectType ' + sObjectType);
        }

        repositoryBySObjectType.put(sObjectType, (Repository)repositoryClass.newInstance());

        return repositoryBySObjectType.get(sObjectType);	
    }

    @TestVisible
    private void setMock(Repository repository) {
        repositoryBySObjectType.put(repository.getSObjectType(), repository);	
    }

    public class RepositoryFactoryException extends Exception {}
}