DECLARE @WorkflowSort int
Select @WorkflowSort = WorkflowSort from pWorkflow where WorkflowID = '40000000-0000-0000-0000-000000000050'
if @WorkflowSort is null set @WorkflowSort = 1
update pWorkflow set WorkflowSort = @WorkflowSort - 1 where WorkflowSort = @WorkflowSort and 
WorkflowID <> '40000000-0000-0000-0000-000000000051' and WorkflowID <> '40000000-0000-0000-0000-000000000052' and
WorkflowID <> '40000000-0000-0000-0000-000000000053' and WorkflowID <> '40000000-0000-0000-0000-000000000054'

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03063'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '03063', GetDate())

END

GO