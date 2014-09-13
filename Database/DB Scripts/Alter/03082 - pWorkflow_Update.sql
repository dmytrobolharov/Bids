DECLARE @WorkflowSort int
Select @WorkflowSort = WorkflowSort from pWorkflow where WorkflowID = '40000000-0000-0000-0000-000000000080'
if @WorkflowSort is null set @WorkflowSort = 1
update pWorkflow set WorkflowSort = @WorkflowSort - 1 where WorkflowSort = @WorkflowSort and 
WorkflowID <> '40000000-0000-0000-0000-000000000080' and WorkflowID <> '40000000-0000-0000-0000-000000000081' and
WorkflowID <> '40000000-0000-0000-0000-000000000082' and WorkflowID <> '40000000-0000-0000-0000-000000000083'

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03082'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03082', GetDate())

END

GO