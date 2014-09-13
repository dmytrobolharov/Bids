IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Translation_NewLang_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Translation_NewLang_SELECT]
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
CREATE PROCEDURE [dbo].[spx_Translation_NewLang_SELECT]
	@sSystemHelpID UNIQUEIDENTIFIER,
	@Translation BIT
AS
DECLARE @isAdmin AS bit
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @tblCulture TABLE (
		CultureIdentifierID VARCHAR(6) PRIMARY KEY,
		CultureName VARCHAR(6),
		CultureLanguage VARCHAR(200),
		HelpLang CHAR(1)
	)
	
	INSERT INTO @tblCulture (CultureIdentifierID, CultureName, CultureLanguage, HelpLang)
	SELECT CultureIndentifierID, CultureName, CultureLanguage, ''
	FROM sSystemCulture 
	WHERE Active = 1 AND dbo.fnx_CheckCultureNameForTranslation(CultureName) = 1
	
	-- english lang if table is empty
	IF NOT EXISTS (SELECT * FROM @tblCulture)
	BEGIN
		INSERT INTO @tblCulture (CultureIdentifierID, CultureName, CultureLanguage, HelpLang)
		SELECT c.CultureIndentifierID, c.CultureName, c.CultureLanguage, ''
		FROM sSystemCulture c 
		WHERE c.CultureName = 'en-US'
	END
			
	--Mark culture with the help
	UPDATE @tblCulture SET HelpLang = '*'
	FROM @tblCulture c INNER JOIN sSystemHelpDetail d
		ON c.CultureIdentifierID = d.CultureIndentifierID
	WHERE d.sSystemHelpID = @sSystemHelpID
			
	IF (@Translation = 1)
		BEGIN
			SELECT CultureIdentifierID, CultureName, CultureLanguage, HelpLang 
			FROM @tblCulture
			WHERE HelpLang = '*'
		END
	ELSE
		BEGIN
			SELECT CultureIdentifierID, CultureName, CultureLanguage, HelpLang 
			FROM @tblCulture
			WHERE HelpLang = ''
		END
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03947'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03947', GetDate())
END

GO

