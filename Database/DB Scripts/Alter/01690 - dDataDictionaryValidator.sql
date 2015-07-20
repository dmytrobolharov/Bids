-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 April 2011                                                                              */
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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'dDataDictionaryValidator') 
    DROP TABLE dDataDictionaryValidator
GO


CREATE TABLE [dbo].[dDataDictionaryValidator](
	ColumnID [uniqueidentifier] NOT NULL,
	ColumnValidatorID [uniqueidentifier] ROWGUIDCOL NOT NULL,
	ColumnValidatorClassID [uniqueidentifier] NOT NULL,
	ColumnValidatorTypeID [uniqueidentifier] NULL,
	ColumnValidatorMinimum integer NULL,
	ColumnValidatorMaximum integer NULL,
	ColumnValidatorText nvarchar(50) NULL,
	CUser [nvarchar](50) NULL,
	CDate [datetime] NULL,
	MUser [nvarchar](50) NULL,
	MDate [datetime] NULL
 CONSTRAINT [PK_dDataDictionaryValidator] PRIMARY KEY CLUSTERED 
(
	[ColumnValidatorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[dDataDictionaryValidator] WITH CHECK ADD CONSTRAINT [FK_dDataDictionaryValidator_dvtValidatorClass] FOREIGN KEY([ColumnValidatorClassID])
REFERENCES [dbo].[dvtValidatorClass] ([ItemID])
GO

ALTER TABLE [dbo].[dDataDictionaryValidator] CHECK CONSTRAINT [FK_dDataDictionaryValidator_dvtValidatorClass]
GO


ALTER TABLE [dbo].[dDataDictionaryValidator] WITH CHECK ADD CONSTRAINT [FK_dDataDictionaryValidator_dvtValidatorType] FOREIGN KEY([ColumnValidatorTypeID])
REFERENCES [dbo].[dvtValidatorType] ([ItemID])
GO

ALTER TABLE [dbo].[dDataDictionaryValidator] CHECK CONSTRAINT [FK_dDataDictionaryValidator_dvtValidatorType]
GO


ALTER TABLE [dbo].[dDataDictionaryValidator] ADD CONSTRAINT [DF_dDataDictionaryValidator_ColumnValidatorID] DEFAULT (newid()) FOR [ColumnValidatorID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01690', GetDate())
GO

SET NOCOUNT Off
GO
