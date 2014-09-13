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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_ServiceConfiguratorQueue_UPDATE_STATUS')
   DROP PROCEDURE spx_ServiceConfiguratorQueue_UPDATE_STATUS
GO


CREATE PROCEDURE spx_ServiceConfiguratorQueue_UPDATE_STATUS
(
	@ServiceConfiguratorQueueID uniqueidentifier,
	@Status int,
	@StatusMessage nvarchar(MAX),
	@PercentComplete int,
	@EndDate datetime = NULL
)
AS

IF @EndDate IS NULL
BEGIN
	UPDATE sServiceConfiguratorQueue
	SET [Status] = @Status,
	[StatusMessage] = @StatusMessage,
	[PercentComplete] = @PercentComplete
	WHERE [ServiceConfiguratorQueueID] = @ServiceConfiguratorQueueID
END
ELSE
BEGIN
	UPDATE sServiceConfiguratorQueue
	SET [Status] = @Status,
	[StatusMessage] = @StatusMessage,
	[PercentComplete] = @PercentComplete,
	[EndDate] = @EndDate
	WHERE [ServiceConfiguratorQueueID] = @ServiceConfiguratorQueueID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03660', GetDate())
GO

SET NOCOUNT Off
GO
