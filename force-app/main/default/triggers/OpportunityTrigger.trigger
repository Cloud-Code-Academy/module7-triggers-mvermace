trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            OpportunityTriggerHelper.validateOppAmount(Trigger.new);
            OpportunityTriggerHelper.setPrimaryContactOnUpdate(Trigger.new);
        }
    }
    if (Trigger.isDelete) {
        if (Trigger.isBefore) {
            OpportunityTriggerHelper.preventDeleteClosedWonBanking(Trigger.old);
        }
    }



}