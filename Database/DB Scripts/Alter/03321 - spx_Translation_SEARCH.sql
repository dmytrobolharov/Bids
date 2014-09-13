IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Translation_SEARCH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Translation_SEARCH]
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
CREATE PROCEDURE [dbo].[spx_Translation_SEARCH]
	@sSystemCulture NVARCHAR(6),
	@searchString NVARCHAR(1000)
AS
	DECLARE @SQL AS NVARCHAR(1000);
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SET @SQL =  'SELECT sSystemHelpID, CultureIndentifierID, LEFT(sSystemHelpDetail_Plain, 300) AS sSystemHelpDetail_Plain, '
	SET @SQL = @SQL + '(SELECT ' + REPLACE(@sSystemCulture, '-', '_') + ' FROM sSystemHelp WHERE sSystemHelpID = sSystemHelpDetail.sSystemHelpID) AS DesignString '
	SET @SQL = @SQL + ' FROM sSystemHelpDetail 
				WHERE sSystemHelpDetail_Plain like N''%' +  CAST(REPLACE(@searchString, '''', '''''') AS NVARCHAR(1000)) + '%'''
	SET @SQL =	@SQL + ' AND
				CultureIndentifierID = (select CultureIndentifierID from sSystemCulture where CultureName = ''' + @sSystemCulture + ''')'
	--PRINT (@SQL)
	EXECUTE (@SQL)
	
END --01
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03321'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03321', GetDate())
END

GO