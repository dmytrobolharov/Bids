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
		  end StartDate
	   , case wti.DueDate
	          when null then wt.DueDate
	          else wti.DueDate
	      end DueDate
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


-- select the dependencies for the workflow template item
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_WorkflowTemplateWorkflowTemplateItemDependency')
drop view vwx_WorkflowTemplateWorkflowTemplateItemDependency
go

create view vwx_WorkflowTemplateWorkflowTemplateItemDependency
    as
select workflowTemplateItemDepID, wti.workflowTemplateID, WorkflowTemplateItemID, dependentWorkflowTemplateItemID, dependentOnWorkflowTemplateItemID, w.Workflow
       ,wtid.WorkflowStatusID, WorkflowStatus, wti.WorkflowID, wtid.WorkflowRuleID, WorkflowRuleDesc, CAST(wti.WorkflowSort as int) as WorkflowSort
  from pWorkflowTemplateItemDep wtid
	   left outer join pWorkflowTemplateItem wti on wti.WorkflowTemplateID = wtid.WorkflowTemplateID and wti.WorkflowTemplateItemID = wtid.DependentOnWorkflowTemplateItemID
	   left outer join pWorkflow w on w.WorkflowID = wti.WorkflowID
	   left outer join pWorkflowStatus ws on ws.WorkflowStatusID = wtid.WorkflowStatusID
	   left outer join pWorkflowRule wr on wr.WorkflowRuleID = wtid.WorkflowRuleID
 go


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03345'))
BEGIN

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03345', GetDate())
	
END
GO

