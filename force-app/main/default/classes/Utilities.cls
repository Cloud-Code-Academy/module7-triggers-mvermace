public inherited sharing class Utilities {
    

    private static Map <String,Schema.SObjectType> globalDescribe = getGlobalDescribe();
    
    public static Map <String,Schema.SObjectType> getGlobalDescribe() {
        if(globalDescribe == null) {
            globalDescribe = Schema.getGlobalDescribe();
        }
        return globalDescribe;
    }

    public static List<String> getPickListValues(String objectApiName, String fieldApiName){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap().get(fieldApiName).getDescribe();
        List<Schema.PicklistEntry> picklistEnt = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : picklistEnt ){
            pickListValuesList.add(pickListVal.getLabel());
        }
        return pickListValuesList;
    }

    

}