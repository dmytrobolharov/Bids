-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 June 2012                                                                               */
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


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sServiceConfiguratorQueue_ServiceConfiguratorQueueID]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sServiceConfiguratorQueue] DROP CONSTRAINT [DF_sServiceConfiguratorQueue_ServiceConfiguratorQueueID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sServiceConfiguratorQueue_Status]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sServiceConfiguratorQueue] DROP CONSTRAINT [DF_sServiceConfiguratorQueue_Status]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sServiceConfiguratorQueue_PercentComplete]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sServiceConfiguratorQueue] DROP CONSTRAINT [DF_sServiceConfiguratorQueue_PercentComplete]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sServiceConfiguratorQueue_RequestedDate]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sServiceConfiguratorQueue] DROP CONSTRAINT [DF_sServiceConfiguratorQueue_RequestedDate]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sServiceConfiguratorQueue]') AND type in (N'U'))
	DROP TABLE [dbo].[sServiceConfiguratorQueue]
GO


SET ANSI_PADDING ON
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sServiceConfiguratorQueue](
	[ServiceConfiguratorQueueID] [uniqueidentifier] NOT NULL,
	[EnvironmentXML] [xml] NOT NULL,
	[SelectedTasksXML] [xml] NOT NULL,
	[Status] [int] NOT NULL,
	[StatusMessage] [nvarchar](max) NULL,
	[PercentComplete] [int] NOT NULL,
	[TaskProgressXML] [xml] NULL,
	[RequestedDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_sServiceConfiguratorQueue] PRIMARY KEY CLUSTERED 
(
	[ServiceConfiguratorQueueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[sServiceConfiguratorQueue] ADD  CONSTRAINT [DF_sServiceConfiguratorQueue_ServiceConfiguratorQueueID]  DEFAULT (newid()) FOR [ServiceConfiguratorQueueID]
GO

ALTER TABLE [dbo].[sServiceConfiguratorQueue] ADD  CONSTRAINT [DF_sServiceConfiguratorQueue_Status]  DEFAULT ((0)) FOR [Status]
GO

ALTER TABLE [dbo].[sServiceConfiguratorQueue] ADD  CONSTRAINT [DF_sServiceConfiguratorQueue_PercentComplete]  DEFAULT ((0)) FOR [PercentComplete]
GO

ALTER TABLE [dbo].[sServiceConfiguratorQueue] ADD  CONSTRAINT [DF_sServiceConfiguratorQueue_RequestedDate]  DEFAULT (getutcdate()) FOR [RequestedDate]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03656', GetDate())
GO

SET NOCOUNT Off
GO
