-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 July 2010                                                                               */
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

ALTER PROCEDURE [dbo].[spx_User_SELECT]
(
@TeamID uniqueidentifier
)
AS 

BEGIN
	SELECT UserId, UserCode, TeamID, FirstName, MiddleName, LastName, Title, Birthday, Company, Street1, Street2, City, State, Zip, Country, Phone, Fax, Mobile, UserName, 
	  PassWord, Email, ContactName1, ContactTitle1, ContactEmail1, ContactName2, ContactTitle2, ContactEmail2, ContactName3, ContactTitle3, ContactEmail3, 
	  ContactName4, ContactTitle4, ContactEmail4, Admin, Active, PublicAccess, TradePartner, LastUpdate, SESSION, SESSIONDATE, SESSIONOS, SCREENWIDTH, 
	  SCREENHEIGHT, FirstName + ' ' + LastName AS FULLNAME, USERDIR, MAILADDR, MAXSIZE, MAXMSGS, FLAGS, TYPE, IP, Picture, CUser, CDate, MUser, MDate, CalendarTemplateID, ActivationID, 
	  ReadOnly, SystemClientID, ServerLocationID, PreferredLang
	FROM Users
	WHERE TeamId = @TeamId
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '236', GetDate())
GO
