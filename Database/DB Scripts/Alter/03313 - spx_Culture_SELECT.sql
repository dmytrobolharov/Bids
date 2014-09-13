IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Culture_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Culture_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rajul Radadia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spx_Culture_SELECT]
	@UserID INT,
	@sSystemHelpID UNIQUEIDENTIFIER
AS
DECLARE @isAdmin AS bit
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT @isAdmin = Admin FROM Users
	WHERE UserId = @UserID;
	
	DECLARE @tblCulture TABLE (
		CultureIdentifierID VARCHAR(6) PRIMARY KEY,
		CultureName VARCHAR(6),
		CultureCountry VARCHAR(200),
		HelpLang CHAR(1)
	)
		
	IF (@isAdmin = 1)
		BEGIN
			INSERT INTO @tblCulture (CultureIdentifierID, CultureName, CultureCountry, HelpLang)
			SELECT CultureIndentifierID, CultureName, CultureCountry, ''
			FROM sSystemCulture 
			WHERE Active = 1
		END
	ELSE
		BEGIN
			INSERT INTO @tblCulture (CultureIdentifierID, CultureName, CultureCountry, HelpLang)
			SELECT c.CultureIndentifierID, c.CultureName, c.CultureCountry, ''
			FROM sSystemCulture c INNER JOIN sSystemHelpDetail d
				ON c.CultureIndentifierID = d.CultureIndentifierID
			WHERE c.Active = 1 AND d.sSystemHelpID=@sSystemHelpID
		END
		
	--Mark culture with the help
	UPDATE @tblCulture SET HelpLang = '*'
	FROM @tblCulture c INNER JOIN sSystemHelpDetail d
		ON c.CultureIdentifierID = d.CultureIndentifierID
	WHERE d.sSystemHelpID = @sSystemHelpID
	
	SELECT CultureIdentifierID, CultureName, CultureCountry, HelpLang 
	FROM @tblCulture
	ORDER BY CultureCountry DESC
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03313'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03313', GetDate())
END

GO