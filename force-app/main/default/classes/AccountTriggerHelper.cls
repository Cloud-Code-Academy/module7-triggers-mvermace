public with sharing class AccountTriggerHelper {
    
    
    public static void setAccountType(List<Account> acc1TriggerNew) {
        String accType = 'Prospect';
        for (Account acct : acc1TriggerNew) {
            if (acct.Type == null) {
                acct.Type = accType;   
            }
        }
    }

    public static void copyShippingToBilling(List<Account> acc2TriggerNew) {
        for (Account acct : acc2TriggerNew) {
            acct.BillingStreet = acct.ShippingStreet;
            acct.BillingCity = acct.ShippingCity;
            acct.BillingState = acct.ShippingState;
            acct.BillingPostalCode = acct.ShippingPostalCode;
            acct.BillingCountry = acct.ShippingCountry;            
        }
    }
    
    public static void setAccountRating(List<Account> acc3TriggerNew) {
        String accRating = 'Hot';
        for (Account acct : acc3TriggerNew) {
            if (acct.Phone != null && acct.Website != null && acct.Fax != null) {
                acct.Rating = accRating;   
            }                    
        }
    }
    
    public static void createContactForAccount(List<Account> acc4TriggerNew) {
        
        List<Contact> newContact = new List<Contact>();
        for (Account acct : acc4TriggerNew) {
            Contact newCont = new Contact();
            newCont.LastName = 'DefaultContact';
            newCont.Email = 'default@email.com';
            newCont.AccountId = acct.Id;    
            newContact.add(newCont);
        }

        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = true;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        Database.insert(newContact, dml);
        
    }
    
}