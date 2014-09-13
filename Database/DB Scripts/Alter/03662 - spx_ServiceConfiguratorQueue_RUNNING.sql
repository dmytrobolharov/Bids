-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 June 2012                                                                               */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_ServiceConfiguratorQueue_RUNNING')
   DROP PROCEDURE spx_ServiceConfiguratorQueue_RUNNING
GO


CREATE PROCEDURE spx_ServiceConfiguratorQueue_RUNNING
(
	@ServiceConfiguratorQueueID uniqueidentifier = NULL
)
AS

IF @ServiceConfiguratorQueueID IS NULL
BEGIN
	SELECT [ServiceConfiguratorQueueID], [EnvironmentXML], [SelectedTasksXML], [Status], [StatusMessage]
		  ,[PercentComplete], [TaskProgressXML], [RequestedDate], [StartDate], [EndDate]
	FROM sServiceConfiguratorQueue
	WHERE [Status] = 1
END
ELSE
BEGIN
	SELECT [ServiceConfiguratorQueueID], [EnvironmentXML], [SelectedTasksXML], [Status], [StatusMessage]
		  ,[PercentComplete], [TaskProgressXML], [RequestedDate], [StartDate], [EndDate]
	FROM sServiceConfiguratorQueue
	WHERE [ServiceConfiguratorQueueID] = @ServiceConfiguratorQueueID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03662', GetDate())
GO

SET NOCOUNT Off
GO
