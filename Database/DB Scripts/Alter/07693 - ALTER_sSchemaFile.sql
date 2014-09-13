-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 May 2014                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

------------------------
-- TABLE: sSchemaFile --
------------------------
IF (OBJECT_ID('sSchemaFile', 'U') IS NOT NULL)
BEGIN
	DROP TABLE [dbo].[sSchemaFile]
END
GO

IF (OBJECT_ID('sSchemaFile', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFile]
	(
		[FileID] [uniqueidentifier] NOT NULL,
		[Path] [nvarchar](512) NOT NULL,
		[FileName] [nvarchar](256) NOT NULL,
		[Report] [xml] NULL,
		[LastModified] [datetime] NOT NULL,
		[AppType] [int] NOT NULL,
		[IsBackUp] [int] NOT NULL,
		[MUser] nvarchar(200) NULL,
		CONSTRAINT [PK_sSchemaFile] PRIMARY KEY CLUSTERED
		(
			[FileID] Asc
		) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


---------------------
-- COLUMN: AppType --
---------------------
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_AppType') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD CONSTRAINT [DF_sSchemaFile_AppType] DEFAULT ((0)) FOR [AppType]
END
GO


----------------------
-- COLUMN: IsBackUp --
----------------------
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_IsBackUp') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD CONSTRAINT [DF_sSchemaFile_IsBackUp] DEFAULT ((0)) FOR [IsBackUp]
END
GO


-------------------
-- COLUMN: MUser --
-------------------
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_MUser') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD CONSTRAINT [DF_sSchemaFile_MUser] DEFAULT ('Administrator') FOR [MUser]
END
GO


---------------------------------
-- INDEX: sSchemaFile_FileName --
---------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFile_FileName' AND object_id = OBJECT_ID('sSchemaFile')
) 
BEGIN
	CREATE INDEX sSchemaFile_FileName ON sSchemaFile (FileName ASC)
END
GO


------------------
-- Default Data --
------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sSchemaFile
	WHERE FileID = '00000000-0000-0000-0000-000000000000'
) 
BEGIN
	INSERT INTO sSchemaFile 
	([FileID]
     ,[Path]
     ,[FileName]
     ,[Report]
     ,[LastModified]
     ,[AppType]
     ,[IsBackUp])
	VALUES 
	('00000000-0000-0000-0000-000000000000'
	 ,''
	 ,'Core_Fields.xml'
	 ,''
	 ,GETUTCDATE()
	 ,-1
	 ,0)
END
GO


IF NOT EXISTS 
( 
	SELECT * 
	FROM sSchemaFile
	WHERE FileID = '00000000-0000-0000-0000-000000000001'
) 
BEGIN
	INSERT INTO sSchemaFile 
	([FileID]
     ,[Path]
     ,[FileName]
     ,[Report]
     ,[LastModified]
     ,[AppType]
     ,[IsBackUp])
	VALUES 
	('00000000-0000-0000-0000-000000000001'
	 ,''
	 ,'Custom_Fields.xml'
	 ,''
	 ,GETUTCDATE()
	 ,-1
	 ,0)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07693', GetDate())
GO

SET NOCOUNT Off
GO
