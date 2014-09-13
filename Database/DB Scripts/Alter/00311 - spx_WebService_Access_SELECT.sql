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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebService_Access_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_WebService_Access_SELECT
GO


CREATE PROCEDURE spx_WebService_Access_SELECT
(@WSClientID uniqueidentifier)
AS 

SELECT sAccessWebService.AccessWebServiceID, 
       sAccessWebService.WSClientID, 
       sAccessWebService.WebServiceSchema, 
       sAccessWebService.AccessRoleID, 
       sAccessWebService.AccessView, 
       sAccessWebService.AccessCreate, 
       sAccessWebService.AccessModify, 
       sAccessWebService.AccessDelete, 
       sAccessWebService.AccessPrint, 
       sAccessWebService.CUser, 
       sAccessWebService.CDate, 
       sAccessWebService.MUser, 
       sAccessWebService.MDate, 
       sWebService.WebServiceID, 
       sWebService.WebServiceName 
FROM sAccessWebService WITH (NOLOCK) INNER JOIN
     sWebService WITH (NOLOCK) ON sAccessWebService.WebServiceID = sWebService.WebServiceID
WHERE (sAccessWebService.WSClientID = @WSClientID)
  AND (sWebService.Active <> 0)
ORDER BY sWebService.WebServiceName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '311', GetDate())
GO
