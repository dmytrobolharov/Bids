-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 August 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_WSClient_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_WSClient_DELETE
GO


CREATE PROCEDURE spx_WSClient_DELETE
(@WSClientID uniqueidentifier)
AS 

DELETE FROM uWebServiceClient
WHERE WSClientID = @WSClientID

DELETE FROM sAccessWebService
WHERE WSClientID = @WSClientID

DELETE FROM sAccessWebServiceItem
WHERE WSClientID = @WSClientID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '317', GetDate())
GO
