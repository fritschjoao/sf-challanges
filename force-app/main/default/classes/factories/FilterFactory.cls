public without sharing class FilterFactory {

    private Map<SObjectType, Type> classBySObjectType;
    private Map<SObjectType, Filter> filterBySObjectType;

    public FilterFactory(Map<SObjectType, Type> classBySObjectType) {
        this.classBySObjectType = classBySObjectType;
        this.filterBySObjectType = new Map<SObjectType, filter>();
    }

    public Filter newInstance(SObjectType sObjectType) {
        if(this.filterBySObjectType.containsKey(sObjectType)) {
            return this.filterBySObjectType.get(sObjectType);
        }

        Type filterClass = this.classBySObjectType.get(sObjectType);

        if(filterClass == null) {
            throw new FilterFactoryException('Filter class not found for SObjectType ' + sObjectType);
        }

        filterBySObjectType.put(sObjectType, (Filter)filterClass.newInstance());

        return filterBySObjectType.get(sObjectType);	
    }

    public class FilterFactoryException extends Exception {}
}