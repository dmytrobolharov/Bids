--select the workflow template items for the workflow template
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_CreateWorkflowTemplate')
drop view vwx_CreateWorkflowTemplate
go

create view vwx_CreateWorkflowTemplate
    as
(    
select WorkflowID, WorkflowTemplateID, WorkflowTemplateItemID, WorkflowAssignedTo,
	   case u1.MiddleName
			when null then 
				u1.FirstName + ' ' + u1.MiddleName + ' ' + u1.LastName
			else
				u1.FirstName + ' ' + u1.LastName
		end WorkflowAssignedToName,
	   WorkflowEscalateTo,
	   case u2.MiddleName
			when null then 
				u2.FirstName + ' ' + u2.MiddleName + ' ' + u2.LastName
			else
				u2.FirstName + ' ' + u2.LastName
		end WorkflowEscalateToName,
	    WorkflowAlerts, wti.WorkflowAccessTypeID, WorkflowAccessTypeDesc, WorkflowSort,
	    WorkflowDays
  from pWorkflowTemplateItem wti
       left outer join Users u1 on u1.UserId = wti.WorkflowAssignedTo
       left outer join Users u2 on u1.UserId = wti.WorkflowEscalateTo
       left outer join pWorkflowAccessType wat on wat.WorkflowAccessTypeID = wti.WorkflowAccessTypeID
 WHERE WorkflowTemplateID = '75541f57-fc4b-46c9-836c-a2582443ba86' 
)       


go



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03446', GetDate())
	

GO


