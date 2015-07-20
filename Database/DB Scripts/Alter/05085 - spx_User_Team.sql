IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_Team]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_Team]
GO

CREATE PROCEDURE [dbo].[spx_User_Team](@TeamID uniqueidentifier)
AS SELECT     UserId, UserCode, TeamID, FirstName, MiddleName, LastName, Title, Birthday, Company, Street1, Street2, City, State, Zip, Country, Phone, Fax, 
                      Mobile, UserName, PassWord, Email, ContactName1, ContactTitle1, ContactEmail1, ContactName2, ContactTitle2, ContactEmail2, ContactName3, 
                      ContactTitle3, ContactEmail3, ContactName4, ContactTitle4, ContactEmail4, Admin, Active, PublicAccess, TradePartner, LastUpdate, SESSION, 
                      SESSIONDATE, FULLNAME, USERDIR, MAILADDR, MAXSIZE, MAXMSGS, FLAGS, TYPE, IP, Picture, CDate, MDate, A_StyleFolder, A_StyleHeader, 
                      A_StyleMaterial, A_StyleArtwork, A_StyleLicensee, A_StyleColorway, A_StyleDesignDetail, A_StyleDevelopmentSpec, A_StyleGradeMeasurment, 
                      PreferredLang
FROM         dbo.Users WITH (NOLOCK)
WHERE     (TeamID = @TeamID)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05085', GetDate())
GO
