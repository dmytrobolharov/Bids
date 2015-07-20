INSERT INTO [dbo].[DCustom1]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
          )
     VALUES
           ('Short'
           ,'S'
           ,'True'           
           ,0
           )
GO


INSERT INTO [dbo].[DCustom1]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
          )
     VALUES
           ('Medium'
           ,'M'
           ,'True'           
           ,1
           )
GO

INSERT INTO [dbo].[DCustom1]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
          )
     VALUES
           ('Long'
           ,'L'
           ,'True'           
           ,2
           )
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01846'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01846', GetDate())
	END

	GO