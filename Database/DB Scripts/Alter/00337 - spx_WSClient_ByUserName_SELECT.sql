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


IF EXISTS (select * from sysobjects where id = object_id('spx_WSClient_ByUserName_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_WSClient_ByUserName_SELECT
GO


CREATE PROCEDURE spx_WSClient_ByUserName_SELECT
(
@UserName nvarchar (25),
@Password nvarchar (25) = NULL
)
AS 

IF @Password IS NULL
BEGIN
    SELECT WSClientID, 
           WSClientName, 
           Address1, 
           Address2, 
           City, 
           State, 
           PostalCode, 
           Country, 
           PhoneNumber, 
           FaxNumber, 
           Username, 
           Password, 
           ContactName1, 
           ContactTitle1, 
           ContactEmail1, 
           ContactName2, 
           ContactTitle2, 
           ContactEmail2, 
           ContactName3, 
           ContactTitle3, 
           ContactEmail3, 
           ContactName4, 
           ContactTitle4, 
           ContactEmail4, 
           Active, 
           CUser, 
           CDate, 
           MUser, 
           MDate
    FROM uWebServiceClient
    WHERE lower(Username) = lower(@Username)
    ORDER BY WSClientName
END

ELSE
BEGIN
    SELECT WSClientID, 
           WSClientName, 
           Address1, 
           Address2, 
           City, 
           State, 
           PostalCode, 
           Country, 
           PhoneNumber, 
           FaxNumber, 
           Username, 
           Password, 
           ContactName1, 
           ContactTitle1, 
           ContactEmail1, 
           ContactName2, 
           ContactTitle2, 
           ContactEmail2, 
           ContactName3, 
           ContactTitle3, 
           ContactEmail3, 
           ContactName4, 
           ContactTitle4, 
           ContactEmail4, 
           Active, 
           CUser, 
           CDate, 
           MUser, 
           MDate
    FROM uWebServiceClient
    WHERE lower(Username) = lower(@Username)
    AND Password = @Password
    ORDER BY WSClientName
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '337', GetDate())
GO
