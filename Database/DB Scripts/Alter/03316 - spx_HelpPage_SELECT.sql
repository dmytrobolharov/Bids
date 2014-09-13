IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_HelpPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_HelpPage_SELECT]
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
CREATE PROCEDURE [dbo].[spx_HelpPage_SELECT] 
	-- Add the parameters for the stored procedure here
	@PrefLang NVARCHAR(6)
AS
	DECLARE @SQL AS NVARCHAR(1000);
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @PrefLang <> ''
	BEGIN
		SET @PrefLang = REPLACE(@PrefLang, '-', '_');
	END
		
	SET @SQL = 'SELECT sSystemHelpID, CASE WHEN ' + @PrefLang + ' <> '''' THEN ' + @PrefLang + ' ELSE DesignString END AS DesignString, sSystemPageID FROM sSystemHelp'
	EXECUTE (@SQL)
	
END --01


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03316'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03316', GetDate())
END

GO