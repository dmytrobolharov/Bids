IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pWorkFlowItem' and COLUMN_NAME = N'StatusID')
       BEGIN 
			
            ALTER TABLE pWorkFlowItem ADD StatusID uniqueidentifier NULL
       END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03069'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03069', GetDate())

END

GO

