// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// string tempvar = 'Enter_your_name_here';
// System.debug('Hello World!');
// System.debug('My name is ' + tempvar);

//List<String> pls = Utilities.getPickListValues('Account', 'AccountSource');
//System.debug(JSON.serializePretty(pls));

Account acc = new Account(
    Name='Mike06', 
    Type='Customer',
    ShippingStreet='504 Pine Crest', 
    Rating = 'Warm'
);
insert acc;

List<Account> accountsToInsert = new List<Account>();
    for (Integer i = 0; i < 400; i++) {
        Account acc = new Account(Name = 'Test Account ' + i);
        accountsToInsert.add(acc);
    }       
insert accountsToInsert;

Account testAccount = new Account(Name = 'Test Account', Industry = 'Banking');salesforce apex 
Insert testAccount;
List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
for (Integer i = 0; i < 20; i++) {
    Opportunity opp = new Opportunity(
        Name = 'Test Opportunity ' + i,
        CloseDate = Date.today().addDays(i),
        StageName = 'Closed Won',
        Amount = 6000,
        AccountId = testAccount.Id
    );
    opportunitiesToInsert.add(opp);
}
insert opportunitiesToInsert;