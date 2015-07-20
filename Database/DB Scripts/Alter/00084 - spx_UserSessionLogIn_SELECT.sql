
ALTER PROCEDURE [dbo].[spx_UserSessionLogIn_SELECT]
(
@UserName varchar(50), 
@Password varchar(50) 
)
AS 

BEGIN
	SELECT UserId, UserCode, TeamID, FirstName, MiddleName, LastName, Title, Birthday, Company, Street1, Street2, City, State, Zip, Country, Phone, Fax, Mobile, UserName, 
	  PassWord, Email, ContactName1, ContactTitle1, ContactEmail1, ContactName2, ContactTitle2, ContactEmail2, ContactName3, ContactTitle3, ContactEmail3, 
	  ContactName4, ContactTitle4, ContactEmail4, Admin, Active, PublicAccess, TradePartner, LastUpdate, SESSION, SESSIONDATE, SESSIONOS, SCREENWIDTH, 
	  SCREENHEIGHT, FULLNAME, USERDIR, MAILADDR, MAXSIZE, MAXMSGS, FLAGS, TYPE, IP, Picture, CUser, CDate, MUser, MDate, CalendarTemplateID, ActivationID, 
	  ReadOnly, SystemClientID, ServerLocationID, PreferredLang
	FROM Users
	WHERE UserName = @UserName AND Password = @Password
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '084', GetDate())