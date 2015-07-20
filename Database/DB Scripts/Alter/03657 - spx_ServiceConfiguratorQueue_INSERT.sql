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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_ServiceConfiguratorQueue_INSERT')
   DROP PROCEDURE spx_ServiceConfiguratorQueue_INSERT
GO


CREATE PROCEDURE spx_ServiceConfiguratorQueue_INSERT
(
	@ServiceConfiguratorQueueID uniqueidentifier = NULL,
	@EnvironmentXML XML,
	@SelectedTasksXML XML
)
AS

IF @ServiceConfiguratorQueueID IS NULL
BEGIN
	INSERT INTO sServiceConfiguratorQueue(EnvironmentXML, SelectedTasksXML)
	VALUES(@EnvironmentXML, @SelectedTasksXML)
END
ELSE
BEGIN
	INSERT INTO sServiceConfiguratorQueue(ServiceConfiguratorQueueID, EnvironmentXML, SelectedTasksXML)
	VALUES(@ServiceConfiguratorQueueID, @EnvironmentXML, @SelectedTasksXML)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03657', GetDate())
GO

SET NOCOUNT Off
GO
