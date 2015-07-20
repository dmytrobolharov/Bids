IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_WorkflowTemplateWorkflowTemplateItemDependency')
drop view vwx_WorkflowTemplateWorkflowTemplateItemDependency
go

create view vwx_WorkflowTemplateWorkflowTemplateItemDependency
    as
select workflowTemplateItemDepID, wti.workflowTemplateID, WorkflowTemplateItemID, dependentWorkflowTemplateItemID, dependentOnWorkflowTemplateItemID, w.Workflow
       ,wtid.WorkflowStatusID, WorkflowStatus, wti.WorkflowID, wtid.WorkflowRuleID, WorkflowRuleDesc, WorkflowAccessTypeID, CAST(wti.WorkflowSort as int) as WorkflowSort
  from pWorkflowTemplateItemDep wtid
	   left outer join pWorkflowTemplateItem wti on wti.WorkflowTemplateID = wtid.WorkflowTemplateID and wti.WorkflowTemplateItemID = wtid.DependentOnWorkflowTemplateItemID
	   left outer join pWorkflow w on w.WorkflowID = wti.WorkflowID
	   left outer join pWorkflowStatus ws on ws.WorkflowStatusID = wtid.WorkflowStatusID
	   left outer join pWorkflowRule wr on wr.WorkflowRuleID = wtid.WorkflowRuleID
 go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03413', GetDate())
	

GO

