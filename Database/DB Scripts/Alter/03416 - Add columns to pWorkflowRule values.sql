if not Exists(select * from pWorkflowRule where WorkflowRuleID = 1)
             
begin      
-- Column Exists 
insert into pWorkflowRule
       (WorkflowRuleID, WorkflowRuleDesc)
 values
       (1, 'AND')
end

go


if not Exists(select * from pWorkflowRule where WorkflowRuleID = 2)
             
begin      
-- Column Exists 
insert into pWorkflowRule
       (WorkflowRuleID, WorkflowRuleDesc)
 values
       (2, 'OR')
end

go


if not Exists(select * from pWorkflowRule where WorkflowRuleID = 3)
             
begin      
-- Column Exists 
insert into pWorkflowRule
       (WorkflowRuleID, WorkflowRuleDesc)
 values
       (3, 'NOT')
end

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03416', GetDate())
	

GO

