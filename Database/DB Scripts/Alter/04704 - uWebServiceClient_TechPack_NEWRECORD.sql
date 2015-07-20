-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 01 January 2013                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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

IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000011'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000011', 'Tech Pack Services', 'TechPackAPI', 'TestPassword', 1)
END

ELSE
BEGIN
	UPDATE uWebServiceClient SET Username = 'TechPackAPI' 
	WHERE WSClientID = '40000000-0000-0000-0000-000000000011'
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04704', GetDate())
GO

SET NOCOUNT Off
GO
