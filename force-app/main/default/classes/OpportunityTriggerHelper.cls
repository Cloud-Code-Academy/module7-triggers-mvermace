public with sharing class OpportunityTriggerHelper {
    
    public static void validateOppAmount(List<Opportunity> oppTriggerNew) {
        for (Opportunity opp : oppTriggerNew) {
            Double minOpp = 5000;
            if (opp.Amount <= minopp) {
                opp.Amount.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void preventDeleteClosedWonBanking(List<Opportunity> oppTriggerOld) {
        // Must run 'extra' query to find Account.Industry.
        List<Opportunity> oppList = [SELECT Id, Name, Amount, StageName, Account.Industry FROM Opportunity WHERE Id IN :oppTriggerOld];
        for (Opportunity opp : oppList) {
            if (opp.StageName == 'Closed Won' && opp.Account.Industry == 'Banking') {
                // opp.Id.addError('<message>') does not work.
                throw new Exception.DmlException('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }

    public static void setPrimaryContactOnUpdate(List<Opportunity> oppTrigger) {
        // Cannot use '[SELECT <fields> FROM Contact WHERE AccountId IN :oppTrigger]' due to Contact and Trigger.new sObject mismatch.
        // So, initialize Set<Id> to hold AccountIds
        Set<Id> oppAccountIdSet = new Set<Id>();
        //Parse the Trigger.New, add AccountId to Set<Id> if AccountId is not null 
        for (Opportunity opp : oppTrigger) { 
            if (opp.AccountId != null) {
                oppAccountIdSet.add(opp.AccountId); 
            }
        }
        // Now build a List<Contact> to hold Contacts with AccountIds in Trigger.New and Title = 'CEO' 
        String contactTitle = 'CEO';
        List<Contact> ceoContacts = [SELECT Id, FirstName, LastName, Title, AccountId FROM Contact WHERE AccountId IN :oppAccountIdSet AND Title = :contactTitle];
        // Build a Map<> of key=AccountId, value=ContactId using (filtered) List<Contact>
        Map<String,String> acctIdToContactIdMap = new Map<String,String>();
        for (Contact cont : ceoContacts) {
            acctIdToContactIdMap.put(cont.AccountId, cont.Id);
        }
        // Parse the Opportunities in Trigger.New and assign the ContactId to the Primary_Contact__c field using the Map<> 
        for (Opportunity opp2 : oppTrigger) {
            opp2.Primary_Contact__c = acctIdToContactIdMap.get(opp2.AccountId);  // We don't care if no Contact is found for the AccountId of this Oppertunity record.
        }
    }

} 