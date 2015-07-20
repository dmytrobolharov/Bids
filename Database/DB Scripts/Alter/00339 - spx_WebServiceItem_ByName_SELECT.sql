-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 August 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebServiceItem_ByName_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_WebServiceItem_ByName_SELECT
GO


CREATE PROCEDURE spx_WebServiceItem_ByName_SELECT
(@WebServiceItemName nvarchar (200))
AS 

SELECT WebServiceItemID, WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active, CUser, CDate, MUser, MDate
FROM sWebServiceItem
WHERE WebServiceItemName = @WebServiceItemName
ORDER BY WebServiceItemName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '339', GetDate())
GO
