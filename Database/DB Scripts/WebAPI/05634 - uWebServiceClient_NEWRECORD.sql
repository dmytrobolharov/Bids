-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 29 April 2013                                                                              */
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

IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000013'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000013', 'Adobe Integration Services', 'Adobe', 'CO6I80aLnwoAz7SMQ2kxOw==', 1)

	EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000013'
END
GO


IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000014'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000014', 'iOS iPhone', 'iPhone', 'CO6I80aLnwoAz7SMQ2kxOw==', 1)

	EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000014'
END
GO


IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000015'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000015', 'iOS iPad', 'iPad', 'CO6I80aLnwoAz7SMQ2kxOw==', 1)

	EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000015'
END
GO


IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000016'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000016', 'Android Phone', 'APhone', 'CO6I80aLnwoAz7SMQ2kxOw==', 1)

	EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000016'
END
GO


IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000017'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000017', 'Android Tablet', 'ATablet', 'CO6I80aLnwoAz7SMQ2kxOw==', 1)

	EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000017'
END
GO


IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000018'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000018', 'YuniquePLM', 'YuniquePLM', 'CO6I80aLnwoAz7SMQ2kxOw==', 1)

	EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000018'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05634', GetDate())
GO

SET NOCOUNT Off
GO
