IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[pWorkflowStatus]'))
drop table pWorkflowStatus
go


select * into pWorkflowStatus from pWorkflowStatusOld
go



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03343'))
BEGIN

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03343', GetDate())
	
END
GO

