IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSampleRequestGCCWorkflow' and COLUMN_NAME = N'Submit')
       BEGIN 
			
            ALTER TABLE pSampleRequestGCCWorkflow ADD Submit int NULL DEFAULT ((1))
       END
GO

Update pSampleRequestGCCWorkflow set Submit = 1 where Submit is null

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02969'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02969', GetDate())

END

GO

