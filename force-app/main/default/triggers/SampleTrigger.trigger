// ❌ Anti‑pattern: all logic stuffed into the trigger, with DML/SOQL in loops.
trigger OpportunityTrigger on Opportunity (before insert, before update, after update) {
    // BEFORE INSERT: validate Closed Won w/ low Amount
    if (Trigger.isBefore && Trigger.isInsert) {
        for (Opportunity o : Trigger.new) {
            if (o.StageName == 'Closed Won' && (o.Amount == null || o.Amount < 1000)) {
                o.addError('Closed Won opportunities must have Amount ≥ 1000.');
            }
        }
    }

    // BEFORE UPDATE: if Stage changed, overwrite Description
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Opportunity o : Trigger.new) {
            Opportunity oldO = Trigger.oldMap.get(o.Id);
            if (o.StageName != oldO.StageName) {
                o.Description = 'Stage changed from ' + oldO.StageName + ' to ' + o.StageName;
            }
        }
    }

    // AFTER UPDATE: when Stage becomes Closed Won, create a follow-up Task
    if (Trigger.isAfter && Trigger.isUpdate) {
        for (Opportunity o : Trigger.new) {
            Opportunity oldO = Trigger.oldMap.get(o.Id);
            if (o.StageName == 'Closed Won' && oldO.StageName != 'Closed Won') {
                Task t = new Task(
                    WhatId     = o.Id,
                    OwnerId    = o.OwnerId,
                    Subject    = 'Send thank-you',
                    Status     = 'Not Started',
                    Priority   = 'Normal',
                    ActivityDate = Date.today()
                );
                insert t; // ❌ DML in a loop
            }
        }
    }
}