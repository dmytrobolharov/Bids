-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 January 2014                                                                            */
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

UPDATE uWebServiceClient
SET WSClientName = 'YuniquePLM Toolkit', Username = 'Toolkit', Active = 1
WHERE WSClientID = '40000000-0000-0000-0000-000000000018'
GO

EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000018'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
             VALUES ('DB_Version', '0.5.0000', '06950', GetDate())
GO

SET NOCOUNT Off
GO
