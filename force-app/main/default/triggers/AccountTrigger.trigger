trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
                AccountTriggerHelper.setAccountType(Trigger.new);
                AccountTriggerHelper.copyShippingToBilling(Trigger.new);
                AccountTriggerHelper.setAccountRating(Trigger.new);
        }

        if (Trigger.isAfter) {
            AccountTriggerHelper.createContactForAccount(Trigger.new);
        }
    }
}