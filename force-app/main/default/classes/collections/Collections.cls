public class Collections {

    public static List<String> toIds(List<SObject> records) {        
        return pullField(records, 'Id');
    }

    public static Set<Id> toSetIds(List<SObject> records) {        
        return toSetIds(toIds(records));
    }

    public static Set<Id> toSetIds(List<String> ids) {
        Set<Id> filtered = new Set<Id>();
        
        for(String id : ids) {
            filtered.add(id);
        }
    
        return filtered;
    }

    public static List<String> pullField(List<SObject> records, String fieldName) {
        if(isEmpty(records)) {
            return new List<String>();
        }

        Set<String> filtered = new Set<String>();
    
        for(SObject record : records) {
            Object fieldValue = SObjects.getFieldValue(record, fieldName);

            if(fieldValue == null) {
                continue;
            } 
            
            filtered.add('' + fieldValue );
        }        
        
        return new List<String>(filtered);
    }

    public static Boolean isEmpty(List<SObject> records) {
        return records == null || records.isEmpty();
    }
}