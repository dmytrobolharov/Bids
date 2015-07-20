-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- *  9 December 2010                                                                           */
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

/****** Object:  Table uUserSetting    Script Date: 12/09/2010 11:22:21 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'PK_uUserSetting') AND type = 'K')
	BEGIN
		ALTER TABLE uUserSetting DROP CONSTRAINT [PK_uUserSetting]
	END
GO

/****** Object:  Table uUserSetting    Script Date: 12/09/2010 11:22:21 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'UC_uUserSetting_Composite') AND type = 'K')
	BEGIN
		ALTER TABLE uUserSetting DROP CONSTRAINT [UC_uUserSetting_Composite]
	END
GO

/****** Object:  Table uUserSetting    Script Date: 12/09/2010 11:22:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uUserSetting') AND type in (N'U'))
	DROP TABLE uUserSetting
GO

/****** Object:  Table uUserSetting    Script Date: 12/09/2010 11:22:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE uUserSetting(
	[UserSettingID] [uniqueidentifier] DEFAULT NEWSEQUENTIALID() NOT NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
	[SettingSection] [nvarchar](200) NOT NULL,
	[SettingKey] [nvarchar](200) NOT NULL,
	[SettingValue] [varbinary](max) NULL,
 CONSTRAINT [PK_uUserSetting] PRIMARY KEY CLUSTERED 
 (
	[UserSettingID] ASC
 )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE uUserSetting
ADD CONSTRAINT [UC_uUserSetting_Composite] UNIQUE (TeamID, SettingSection, SettingKey)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '858', GetDate())
GO
