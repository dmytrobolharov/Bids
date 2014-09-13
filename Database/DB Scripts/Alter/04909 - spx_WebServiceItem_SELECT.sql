-- ******************************************************************************************** */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebServiceItem_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_WebServiceItem_SELECT
GO


CREATE PROCEDURE spx_WebServiceItem_SELECT
(
	@WebServiceItemID uniqueidentifier = NULL
)
AS 

IF @WebServiceItemID IS NULL
BEGIN
	SELECT WebServiceItemID, WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active, CUser, CDate, MUser, MDate
	FROM sWebServiceItem
    ORDER BY WebServiceItemName
END

ELSE
BEGIN
	SELECT WebServiceItemID, WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active, CUser, CDate, MUser, MDate
	FROM sWebServiceItem
    WHERE WebServiceItemID = @WebServiceItemID
    ORDER BY WebServiceItemName
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04909', GetDate())
GO
