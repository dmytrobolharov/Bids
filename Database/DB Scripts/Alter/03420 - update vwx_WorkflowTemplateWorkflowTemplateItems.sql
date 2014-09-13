--select the workflow template items for the workflow template
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_WorkflowTemplateWorkflowTemplateItems')
drop view vwx_WorkflowTemplateWorkflowTemplateItems
go

create view vwx_WorkflowTemplateWorkflowTemplateItems
    as
(select 
	(select COUNT(*) from pWorkflowTemplateItemDep where DependentWorkflowTemplateItemID = WorkflowTemplateItemID) RequirementNum    
	, *
from
(
select wt.WorkflowTemplateID, WorkflowTemplateItemID, Workflow, WorkflowAccessTypeID
       --, RequirementNum
	   , case wti.StartDate
			  when null then wt.StartDate
			  else wti.StartDate
		  end PlannedStartDate
	   , case wti.DueDate
	          when null then wt.DueDate
	          else wti.DueDate
	      end PlannedDueDate
	   , 
	   case WorkflowDays  
			when null then WorkDays
			else WorkflowDays
		end WorkDays
	   , WorkflowAssignedTo, WorkflowEscalateTo, WorkflowAlerts, CAST(wti.WorkflowSort as int) WorkflowSort
  from pWorkflowTemplate wt
	   left outer join pWorkflowTemplateItem wti on wti.WorkflowTemplateID = wt.WorkflowTemplateID
	   left outer join pWorkflow w on w.WorkflowID = wti.WorkflowID
 ) x
)
go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03420', GetDate())
	

GO

