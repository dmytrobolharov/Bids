IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCategoryFiltered_ByStyleType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCategoryFiltered_ByStyleType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCategoryFiltered_ByStyleType_SELECT]
	@StyleTypeID INT
	, @OrderBy NVARCHAR(200)
AS
BEGIN

	DECLARE @sqlQuery NVARCHAR(MAX)
	
	SET @sqlQuery = 'SELECT scst.StyleCategoryID, sc.StyleCategory FROM pStyleCategory sc ' +
					'INNER JOIN pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID ' +
					'WHERE scst.StyleTypeID = @StyleTypeID AND sc.Active = 1 '
						
	IF @OrderBy IS NOT NULL AND @OrderBy <> ''
	BEGIN
		SET @sqlQuery = @sqlQuery + 'ORDER BY ' + 'sc.' + REPLACE(@OrderBy, ',', ', sc.')
	END
	ELSE
	BEGIN
		SET @sqlQuery = @sqlQuery + 'ORDER BY sc.StyleCategory'
	END
	
	exec sp_executesql @sqlQuery,
		N'@StyleTypeID int',
		@StyleTypeID = @StyleTypeID	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08333', GetDate())
GO
