-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 January 2013                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
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


-- Control Panel
UPDATE sWebService
SET Active = 0
WHERE WebServiceName = 'Control Panel'
GO


-- Seam
UPDATE sWebService
SET Active = 0
WHERE WebServiceName = 'Seam'
GO


-- Team and Group / Group
DECLARE @GroupWSID uniqueidentifier
SELECT @GroupWSID = WebServiceID
FROM sWebService
WHERE WebServiceName = 'Team and Group'

IF @GroupWSID IS NOT NULL
BEGIN
	-- Team and Group / Group
	UPDATE sWebServiceItem
	SET Active = 0
	WHERE WebServiceItemName = 'Group'
	AND WebServiceID = @GroupWSID 
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04908', GetDate())
GO

SET NOCOUNT Off
GO
