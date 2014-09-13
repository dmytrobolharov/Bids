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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebServiceItem_Access_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_WebServiceItem_Access_SELECT
GO


CREATE PROCEDURE spx_WebServiceItem_Access_SELECT
(
@WSClientID uniqueidentifier,
@WebServiceID uniqueidentifier
)
AS 

SELECT sAccessWebServiceItem.AccessWebServiceItemID, 
       sAccessWebServiceItem.WebServiceID, 
       sAccessWebServiceItem.WebServiceItemID, 
       sAccessWebServiceItem.AccessRoleID, 
       sAccessWebServiceItem.AccessView, 
       sAccessWebServiceItem.AccessCreate, 
       sAccessWebServiceItem.AccessModify, 
       sAccessWebServiceItem.AccessDelete, 
       sAccessWebServiceItem.AccessPrint, 
       sAccessWebServiceItem.WSClientID, 
       sAccessWebServiceItem.WebServiceItemSchema, 
       sAccessWebServiceItem.CUser, 
       sAccessWebServiceItem.CDate, 
       sAccessWebServiceItem.MUser, 
       sAccessWebServiceItem.MDate,
       sWebServiceItem.WebServiceItemName, 
       sWebServiceItem.WebServiceItemDefaultSchema, 
       sWebServiceItem.Active
FROM sAccessWebServiceItem WITH (NOLOCK) INNER JOIN
     sWebServiceItem WITH (NOLOCK) ON sAccessWebServiceItem.WebServiceItemID = sWebServiceItem.WebServiceItemID
WHERE (sAccessWebServiceItem.WSClientID = @WSClientID) 
  AND (sAccessWebServiceItem.WebServiceID = @WebServiceID)
  AND (sWebServiceItem.Active <> 0)
ORDER BY sWebServiceItem.WebServiceItemName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '314', GetDate())
GO
