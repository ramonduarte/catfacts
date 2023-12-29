trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            handler.afterInsert(Trigger.new, Trigger.newMap);
        }
    }
}
