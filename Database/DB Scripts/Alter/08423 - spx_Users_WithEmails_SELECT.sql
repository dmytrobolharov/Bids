IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Users_WithEmails_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Users_WithEmails_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Users_WithEmails_SELECT]
AS

	SELECT u.TeamID, u.Email
		, ISNULL(FirstName, '') + ' ' + ISNULL(LastName, '') AS FullName
	FROM Users u
	WHERE TradePartner = 0
		AND Email <> ''
		AND Active = 1
	ORDER BY FirstName


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08423', GetDate())
GO
