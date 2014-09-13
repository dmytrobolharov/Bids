
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'Active')
       BEGIN 
             ALTER TABLE pGRClassRange ADD Active int NULL            
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'SizeRange')
       BEGIN 
             ALTER TABLE pGRClassRange ADD SizeRange nvarchar(60) NULL            
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'MUser')
       BEGIN 
             ALTER TABLE pGRClassRange ADD MUser nvarchar(25) NULL          
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'MDate')
       BEGIN 
             ALTER TABLE pGRClassRange ADD MDate datetime NULL            
       END
GO

IF  EXISTS (SELECT * from sysobjects WHERE Name = N'DF_pGRClassRange_Active' AND type = 'D')
	BEGIN
		ALTER TABLE pGRClassRange DROP CONSTRAINT [DF_pGRClassRange_Active]
	END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'Active')
       BEGIN 
             ALTER TABLE pGRClassRange ADD CONSTRAINT DF_pGRClassRange_Active DEFAULT 0 FOR Active            
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeRangeDetail' and COLUMN_NAME = N'ClassRangeId')
       BEGIN 
             ALTER TABLE pGRSizeRangeDetail ADD ClassRangeId uniqueidentifier NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeClassCompany' and COLUMN_NAME = N'SizeClass')
       BEGIN 
             ALTER TABLE pGRSizeClassCompany ADD SizeClass nvarchar(60) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeClassCompany' and COLUMN_NAME = N'CUser')
       BEGIN 
             ALTER TABLE pGRSizeClassCompany ADD CUser nvarchar(25) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeClassCompany' and COLUMN_NAME = N'CDate')
       BEGIN 
             ALTER TABLE pGRSizeClassCompany ADD CDate datetime NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeClassCompany' and COLUMN_NAME = N'MUser')
       BEGIN 
             ALTER TABLE pGRSizeClassCompany ADD MUser nvarchar(25) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeClassCompany' and COLUMN_NAME = N'MDate')
       BEGIN 
             ALTER TABLE pGRSizeClassCompany ADD MDate datetime NULL
       END
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'Product')
       BEGIN 
             ALTER TABLE pGRProductCompany ADD Product nvarchar(100) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'CUser')
       BEGIN 
             ALTER TABLE pGRProductCompany ADD CUser nvarchar(25) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'CDate')
       BEGIN 
             ALTER TABLE pGRProductCompany ADD CDate datetime NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'MUser')
       BEGIN 
             ALTER TABLE pGRProductCompany ADD MUser nvarchar(25) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'MDate')
       BEGIN 
             ALTER TABLE pGRProductCompany ADD MDate datetime NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'RefCode')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD RefCode nvarchar(12)
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'POMDesc')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD POMDesc nvarchar(100)
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'How2MeasName')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD How2MeasName nvarchar(128) Null
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'How2MeasText')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD How2MeasText nvarchar(500) Null
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'SortField')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD SortField int Null
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'CnvtPOMDesc')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD CnvtPOMDesc nvarchar(100) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'IsLinked')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD IsLinked int NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'MUser')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD MUser nvarchar(25) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'MDate')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD MDate datetime NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '907', GetDate())
GO

