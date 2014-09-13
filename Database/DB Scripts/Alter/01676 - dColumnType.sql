-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 March 2011                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'dColumnType') 
    DROP TABLE dColumnType
GO


CREATE TABLE [dbo].[dColumnType](
	[ColumnTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ColumnTypeName] [nvarchar](50) NOT NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_dColumnType] PRIMARY KEY CLUSTERED 
(
	[ColumnTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[dColumnType] ADD  CONSTRAINT [DF_dColumnType_ColumnTypeID]  DEFAULT (newid()) FOR [ColumnTypeID]
GO


INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('attributebox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('calendarbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('calendareventbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('calendarrangebox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('checkbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('colorbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('contentbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('currencybox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('dropdowncolor', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('dropdownlist', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('hiddenbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('idbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('label', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('memobox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('percentbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('placeholder', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('radiobox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('radiobutton', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('radiolist', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('system', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('textbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('userbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('windowbox', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('image', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('materialimage', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('colorimage', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('styleimage', 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnType (ColumnTypeName, CUser, CDate, MUser, MDate) VALUES ('pomimage', 'administrator', getdate(), 'administrator', getdate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01676', GetDate())
GO

SET NOCOUNT Off
GO
