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


IF EXISTS (select * from sysobjects where id = object_id('spx_WSClient_Password_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_WSClient_Password_UPDATE
GO

CREATE PROCEDURE spx_WSClient_Password_UPDATE
(
@WSClientID uniqueidentifier, 
@Username nvarchar (25), 
@Password nvarchar (25), 
@MUser nvarchar (200), 
@MDate datetime
)
AS 

UPDATE uWebServiceClient 
SET Username = @Username, 
Password = @Password, 
MUser = @MUser, 
MDate = @MDate 
WHERE WSClientID = @WSClientID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '320', GetDate())
GO
