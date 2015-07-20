-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 July 2010                                                                               */
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
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_UserSessionID_SELECT') 
DROP PROCEDURE spx_UserSessionID_SELECT
GO

CREATE PROCEDURE [dbo].[spx_UserSessionID_SELECT]
(
@SessionId varchar(50)
)
AS 

BEGIN
	SELECT TOP 1 UserId, UserCode, TeamID, FirstName, MiddleName, LastName, Title, Birthday, Company, Street1, Street2, City, State, Zip, Country, Phone, Fax, Mobile, UserName, 
	  PassWord, Email, ContactName1, ContactTitle1, ContactEmail1, ContactName2, ContactTitle2, ContactEmail2, ContactName3, ContactTitle3, ContactEmail3, 
	  ContactName4, ContactTitle4, ContactEmail4, Admin, Active, PublicAccess, TradePartner, LastUpdate, SESSION, SESSIONDATE, SESSIONOS, SCREENWIDTH, 
	  SCREENHEIGHT, FULLNAME, USERDIR, MAILADDR, MAXSIZE, MAXMSGS, FLAGS, TYPE, IP, Picture, CUser, CDate, MUser, MDate, CalendarTemplateID, ActivationID, 
	  ReadOnly, SystemClientID, ServerLocationID, PreferredLang
	FROM Users
	WHERE [SESSION]  = @SessionId
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '265', GetDate())
GO