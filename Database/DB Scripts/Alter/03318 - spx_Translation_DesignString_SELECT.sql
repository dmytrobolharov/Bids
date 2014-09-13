IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Translation_DesignString_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Translation_DesignString_SELECT]
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
CREATE PROCEDURE [dbo].[spx_Translation_DesignString_SELECT]
	@sSystemHelpID UNIQUEIDENTIFIER,
	@sSystemCulture NVARCHAR(6)
AS
	DECLARE @SQL AS NVARCHAR(1000);
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @sSystemCulture <> ''
	BEGIN --02
		SET @sSystemCulture = REPLACE(@sSystemCulture, '-', '_');
	END --02
	
	SET @SQL = 'SELECT	CASE WHEN ' + @sSystemCulture + ' <> '''' THEN ' + @sSystemCulture +
									  ' ELSE DesignString END AS DesignString
						FROM sSystemHelp
						WHERE sSystemHelpID = ' + '''' + CAST(@sSystemHelpID AS VARCHAR(36)) + ''''
	--PRINT (@SQL)
	EXECUTE (@SQL)
END --01

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03318'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03318', GetDate())
END

GO