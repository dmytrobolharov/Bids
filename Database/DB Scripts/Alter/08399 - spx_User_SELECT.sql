IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_User_SELECT]
(
@TeamID uniqueidentifier
)
AS 

BEGIN
	SELECT UserId, UserCode, TeamID, FirstName, MiddleName, LastName, Title, Birthday, Company, Street1, Street2, City, State, Zip, Country, Phone, Fax, Mobile, UserName, 
	  PassWord, Email, ContactName1, ContactTitle1, ContactEmail1, ContactName2, ContactTitle2, ContactEmail2, ContactName3, ContactTitle3, ContactEmail3, 
	  ContactName4, ContactTitle4, ContactEmail4, Admin, Active, PublicAccess, TradePartner, LastUpdate, SESSION, SESSIONDATE, SESSIONOS, SCREENWIDTH, 
	  SCREENHEIGHT, ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') AS FULLNAME, USERDIR, MAILADDR, MAXSIZE, MAXMSGS, FLAGS, TYPE, IP, Picture, CUser, CDate, MUser, MDate, CalendarTemplateID, ActivationID, 
	  ReadOnly, SystemClientID, ServerLocationID, PreferredLang
	FROM Users
	WHERE TeamId = @TeamId
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08399', GetDate())
GO
