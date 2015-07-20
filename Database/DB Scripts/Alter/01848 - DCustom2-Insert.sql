INSERT INTO [dbo].[DCustom2]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
           )
     VALUES
           ('A'
           ,'1'
           ,'True'           
           ,'0'
          )
GO

INSERT INTO [dbo].[DCustom2]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
           )
     VALUES
           ('B'
           ,'2'
           ,'True'           
           ,'1'
          )
GO

INSERT INTO [dbo].[DCustom2]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
           )
     VALUES
           ('C'
           ,'3'
           ,'True'           
           ,'2'
          )
GO

INSERT INTO [dbo].[DCustom2]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
           )
     VALUES
           ('CC'
           ,'4'
           ,'True'           
           ,'3'
          )
GO

INSERT INTO [dbo].[DCustom2]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
           )
     VALUES
           ('D'
           ,'5'
           ,'True'           
           ,'4'
          )
GO

INSERT INTO [dbo].[DCustom2]
           ([Custom]
           ,[CustomKey]
           ,[Active]           
           ,[CustomSort]
           )
     VALUES
           ('DD'
           ,'6'
           ,'True'           
           ,'5'
          )
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01848'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01848', GetDate())
	END

	GO