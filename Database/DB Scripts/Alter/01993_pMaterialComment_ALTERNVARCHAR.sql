ALTER TABLE pMaterialComment ALTER COLUMN MaterialComment nvarchar(max)
GO

ALTER TABLE pSampleRequestComment ALTER COLUMN SampleRequestComment nvarchar(max)
GO

ALTER TABLE pStyleComment ALTER COLUMN StyleComment nvarchar(max)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01993'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.0000'
			,'01993'
			,GetDate()
		)
END	

GO