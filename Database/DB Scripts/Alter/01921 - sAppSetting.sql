-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 September 2011                                                                           */
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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'sAppSetting') 
    DROP TABLE sAppSetting
GO


CREATE TABLE [dbo].[sAppSetting]
(
	[AppSettingID] [uniqueidentifier] ROWGUIDCOL NOT NULL,
	[ConfigFileName] [nvarchar](255) NOT NULL,
	[AppSettingComment] [nvarchar](200) NULL,
	[AppSettingKey] [nvarchar](200) NULL,
	[AppSettingValue] [nvarchar](4000) NULL,
	[AppSettingNote] [nvarchar](400) NULL,
	[AppSettingOrder] [integer] NOT NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAppSetting] PRIMARY KEY CLUSTERED 
(
	[AppSettingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sAppSetting] ADD  CONSTRAINT [DF_sAppSetting_AppSettingID]  DEFAULT (newid()) FOR [AppSettingID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01921', GetDate())
GO

SET NOCOUNT Off
GO
