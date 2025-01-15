public class BedFilter extends Filter {

    public Map<String, List<Bed__c>> groupByCategory(List<Bed__c> beds) {
        return Maps.grouppBy('Category__c', beds);
    }
}