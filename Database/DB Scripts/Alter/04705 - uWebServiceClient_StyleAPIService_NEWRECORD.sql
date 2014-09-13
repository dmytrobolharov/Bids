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

IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000012'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000012', 'Style API Services', 'StyleAPI', 'TestPassword', 1)
END

ELSE
BEGIN
	UPDATE uWebServiceClient SET Username = 'StyleAPI' 
	WHERE WSClientID = '40000000-0000-0000-0000-000000000012'
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04705', GetDate())
GO

SET NOCOUNT Off
GO
