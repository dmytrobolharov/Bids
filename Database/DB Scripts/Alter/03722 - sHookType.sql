-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 Juky 2012                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sHookType_HookTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sHookType] DROP CONSTRAINT [DF_sHookType_HookTypeID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sHookType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sHookType] DROP CONSTRAINT [DF_sHookType_Active]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sHookType]') AND type in (N'U'))
DROP TABLE [dbo].[sHookType]
GO


CREATE TABLE [dbo].[sHookType](
	[HookTypeID] [uniqueidentifier] NOT NULL,
	[HookType] [nvarchar](50) NOT NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sHookType] PRIMARY KEY CLUSTERED 
(
	[HookTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sHookType] ADD  CONSTRAINT [DF_sHookType_HookTypeID]  DEFAULT (newid()) FOR [HookTypeID]
GO

ALTER TABLE [dbo].[sHookType] ADD  CONSTRAINT [DF_sHookType_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sHookType (HookType, Active, CUser, CDate, MUser, MDate)
VALUES ('Before Save', 1, 'administrator', getutcdate(), 'administrator', getutcdate())
GO

INSERT INTO sHookType (HookType, Active, CUser, CDate, MUser, MDate)
VALUES ('After Save', 1, 'administrator', getutcdate(), 'administrator', getutcdate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03722', GetDate())
GO

SET NOCOUNT Off
GO
