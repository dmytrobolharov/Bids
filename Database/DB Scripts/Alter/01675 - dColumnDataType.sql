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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'dColumnDataType') 
    DROP TABLE dColumnDataType
GO


CREATE TABLE [dbo].[dColumnDataType](
	[ColumnDataTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ColumnDataTypeName] [nvarchar](50) NOT NULL,
	[ColumnDataTypeLength] [int] NOT NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_dColumnDataType] PRIMARY KEY CLUSTERED 
(
	[ColumnDataTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[dColumnDataType] ADD  CONSTRAINT [DF_dColumnDataType_ColumnDataTypeID]  DEFAULT (newid()) FOR [ColumnDataTypeID]
GO

ALTER TABLE [dbo].[dColumnDataType] ADD  CONSTRAINT [DF_dColumnDataType_ColumnDataTypeLength]  DEFAULT (0) FOR [ColumnDataTypeLength]
GO


INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('boolean', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('datetime', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('decimal', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('fraction', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('integer', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('money', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('percent', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('query', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(2)', 2, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(5)', 5, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(10)', 10, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(20)', 20, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(50)', 50, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(100)', 100, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(200)', 200, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(1000)', 1000, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(2000)', 2000, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('string(3000)', 3000, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('systemdate', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('systemstring', 0, 'administrator', getdate(), 'administrator', getdate())
GO
INSERT INTO dColumnDataType (ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate) 
VALUES ('guid', 0, 'administrator', getdate(), 'administrator', getdate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01675', GetDate())
GO

SET NOCOUNT Off
GO
