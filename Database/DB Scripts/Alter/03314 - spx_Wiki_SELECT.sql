IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Wiki_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Wiki_SELECT]
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
CREATE PROCEDURE [dbo].[spx_Wiki_SELECT]
	@sSystemHelpID UNIQUEIDENTIFIER,
	@sSystemCulture NVARCHAR(6)
AS
	DECLARE @SQL AS NVARCHAR(1000),
			@CultureIdentifierID AS VARCHAR(6);
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @sSystemCulture <> ''
	BEGIN --02
		SELECT @CultureIdentifierID = CultureIndentifierID FROM sSystemCulture WHERE CultureName = @sSystemCulture
		SET @sSystemCulture = REPLACE(@sSystemCulture, '-', '_');
	END --02
	
	CREATE TABLE #Help (
		sSystemHelpID VARCHAR(50),
		DesignString NVARCHAR(200),
		sSystemHelpDetail NVARCHAR(MAX),
		CultureIdentifierID VARCHAR(6)) --PRIMARY KEY)
	
	SET @SQL = 'INSERT INTO #Help (sSystemHelpID, DesignString, sSystemHelpDetail, CultureIdentifierID) '
	SET @SQL = @SQL + 'SELECT h.sSystemHelpID, 
							CASE WHEN ' + @sSystemCulture + ' <> '''' THEN ' + @sSystemCulture +
									  ' ELSE DesignString END AS DesignString,
							d.sSystemHelpDetail,
							d.CultureIndentifierID
						FROM sSystemHelp h LEFT JOIN sSystemHelpDetail d 
								ON h.sSystemHelpID = d.sSystemHelpID '
	--PRINT (@SQL)
	EXECUTE (@SQL)
	
	If EXISTS (SELECT * FROM #Help WHERE sSystemHelpID=@sSystemHelpID AND CultureIdentifierID=@CultureIdentifierID)
		BEGIN
			SELECT sSystemHelpID, DesignString, sSystemHelpDetail, CultureIdentifierID
			FROM #Help
			WHERE sSystemHelpID=@sSystemHelpID AND CultureIdentifierID=@CultureIdentifierID
		END
	ELSE
		BEGIN
			SELECT sSystemHelpID, DesignString, '' AS sSystemHelpDetail, '' AS CultureIdentifierID
			FROM #Help
			WHERE sSystemHelpID=@sSystemHelpID
		END
	
	DROP TABLE #Help
END --01

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03314'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03314', GetDate())
END

GO
