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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'dDataDictionary') 
    DROP TABLE dDataDictionary
GO


CREATE TABLE [dbo].[dDataDictionary](
	ColumnID [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	ColumnName [nvarchar](50) NOT NULL,
	ColumnAlias [nvarchar](200) NULL,
	ColumnDataTypeID [uniqueidentifier] NOT NULL,
	ColumnTypeID [uniqueidentifier] NOT NULL,
	ColumnCellWidth nvarchar(50) NULL,
	ColumnSearch integer NULL,
	ColumnGridWidth integer NULL,
	ColumnGridSearch integer NULL,
	ColumnLookupQuery [nvarchar](3000) NULL,
	ColumnSelect integer NULL,
	ColumnTextColumn [nvarchar](50) NULL,
	ColumnValueColumn [nvarchar](50) NULL,
	ColumnAutoPostBack integer NULL,
	ColumnAddNullField integer NULL,
	CUser [nvarchar](50) NULL,
	CDate [datetime] NULL,
	MUser [nvarchar](50) NULL,
	MDate [datetime] NULL
 CONSTRAINT [PK_dDataDictionary] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[dDataDictionary]  WITH CHECK ADD  CONSTRAINT [FK_dDataDictionary_dColumnDataType] FOREIGN KEY([ColumnDataTypeID])
REFERENCES [dbo].[dColumnDataType] ([ColumnDataTypeID])
GO

ALTER TABLE [dbo].[dDataDictionary] CHECK CONSTRAINT [FK_dDataDictionary_dColumnDataType]
GO

ALTER TABLE [dbo].[dDataDictionary]  WITH CHECK ADD  CONSTRAINT [FK_dDataDictionary_dColumnType] FOREIGN KEY([ColumnTypeID])
REFERENCES [dbo].[dColumnType] ([ColumnTypeID])
GO

ALTER TABLE [dbo].[dDataDictionary] CHECK CONSTRAINT [FK_dDataDictionary_dColumnType]
GO

ALTER TABLE [dbo].[dDataDictionary] ADD  CONSTRAINT [DF_dDataDictionary_ColumnID]  DEFAULT (newid()) FOR [ColumnID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01677', GetDate())
GO

SET NOCOUNT Off
GO
