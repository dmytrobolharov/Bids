alter table pWorkflowStatus
  add WorkflowStatusOrderNum		int null
  go

update pWorkflowStatus
   set WorkflowStatusOrderNum = WorkflowStatusID
go


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03346'))
BEGIN

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03346', GetDate())
	
END
GO

