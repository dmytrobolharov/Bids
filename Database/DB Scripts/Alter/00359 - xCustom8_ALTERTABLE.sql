
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 June 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--



/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.xCustom8
	DROP CONSTRAINT DF_xCustom8_CustomID
GO
CREATE TABLE dbo.Tmp_xCustom8
	(
	Custom nvarchar(200) NOT NULL,
	CustomKey nvarchar(10) NULL,
	Active int NULL,
	CUser nvarchar(200) NULL,
	CDate datetime NULL,
	MUser nvarchar(200) NULL,
	MDate datetime NULL,
	CustomSort nvarchar(5) NULL,
	CustomID uniqueidentifier NOT NULL
	)  ON [PRIMARY]
GO
DECLARE @v sql_variant 
SET @v = N'109'
EXECUTE sp_addextendedproperty N'MS_DisplayControl', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_xCustom8', N'COLUMN', N'CustomKey'
SET @v = N''
EXECUTE sp_addextendedproperty N'MS_Format', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_xCustom8', N'COLUMN', N'CustomKey'
SET @v = N'0'
EXECUTE sp_addextendedproperty N'MS_IMEMode', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_xCustom8', N'COLUMN', N'CustomKey'
GO
ALTER TABLE dbo.Tmp_xCustom8 ADD CONSTRAINT
	DF_xCustom8_CustomID DEFAULT (newid()) FOR CustomID
GO
IF EXISTS(SELECT * FROM dbo.xCustom8)
	 EXEC('INSERT INTO dbo.Tmp_xCustom8 (Custom, CustomKey, Active, CUser, CDate, MUser, MDate, CustomSort, CustomID)
		SELECT Custom, CustomKey, CONVERT(int, Active), CUser, CDate, MUser, MDate, CustomSort, CustomID FROM dbo.xCustom8 WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.xCustom8
GO
EXECUTE sp_rename N'dbo.Tmp_xCustom8', N'xCustom8', 'OBJECT' 
GO
ALTER TABLE dbo.xCustom8 ADD CONSTRAINT
	PK_xCustom8 PRIMARY KEY CLUSTERED 
	(
	CustomID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '359', GetDate())
GO