-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 August 2010                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebService_ByName_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_WebService_ByName_SELECT
GO


CREATE PROCEDURE spx_WebService_ByName_SELECT
(@WebServiceName nvarchar (200))
AS 

SELECT WebServiceID, WebServiceName, WebServiceDefaultSchema, Active, CUser, CDate, MUser, MDate
FROM sWebService
WHERE WebServiceName = @WebServiceName
ORDER BY WebServiceName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '336', GetDate())
GO
