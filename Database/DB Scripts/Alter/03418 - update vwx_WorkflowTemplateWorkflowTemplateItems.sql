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

select wt.WorkflowTemplateID, WorkflowTemplateItemID, Workflow, wti.WorkflowAccessTypeID, WorkflowAccessTypeDesc
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
	   , WorkflowAssignedTo, 
	   case 
	        when u1.MiddleName is not null then
				 u1.FirstName + ' ' + u1.MiddleName + ' ' + u1.LastName
	        else
				 u1.FirstName + ' ' + u1.LastName
	    end WorkflowAssignedToName
	   , WorkflowEscalateTo, 
	   case 
	        when u2.MiddleName is not null then
				 u2.FirstName + ' ' + + u2.MiddleName + ' ' + u2.LastName 
			else
				 u2.FirstName + ' ' + u2.LastName 
	    end WorkflowEscalateToName
	   , WorkflowAlerts, CAST(wti.WorkflowSort as int) WorkflowSort
  from pWorkflowTemplate wt
	   left outer join pWorkflowTemplateItem wti on wti.WorkflowTemplateID = wt.WorkflowTemplateID
	   left outer join pWorkflow w               on w.WorkflowID = wti.WorkflowID
	   left outer join pWorkflowAccessType wat   on wat.WorkflowAccessTypeID = wti.WorkflowAccessTypeID
	   left outer join Users u1                  on u1.UserId = wti.WorkflowAssignedTo 
	   left outer join Users u2                  on u2.UserId = wti.WorkflowEscalateTo

	) x
)
go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03418', GetDate())

GO




