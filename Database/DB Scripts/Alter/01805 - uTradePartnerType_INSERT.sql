INSERT INTO [dbo].[uTradePartnerType]
           ([CustomKey]
           ,[Custom]
           ,[Active]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate]
           ,[CustomId])
     VALUES
           ('3'
           ,'Factory'
           ,1
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,'6f18848c-3aa4-44d6-8180-504eaffcd02b')
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01805'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01805', GetDate())
END

GO 