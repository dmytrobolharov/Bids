--select the workflow template items for the workflow template
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_WorkflowTemplateWorkflowTemplateItemsActualDates')
drop view vwx_WorkflowTemplateWorkflowTemplateItemsActualDates
go

create view vwx_WorkflowTemplateWorkflowTemplateItemsActualDates
    as

select StyleID, mapdetail Workflow, WorkStart ActualStartDate, WorkDue ActualDueDate, WorkDay ActualWorkDays,  CAST(a.WorkSort AS int) AS WorkSort, 
	   WorkflowTemplateItemID, StyleSet
  from pStyleWorkflow AS a WITH (NOLOCK) 
       inner join Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map
       left outer join pWorkflowTemplateItemDep wtid on wtid.DependentWorkflowTemplateItemID = a.WorkflowTemplateItemID
go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03643', GetDate())
	

GO

