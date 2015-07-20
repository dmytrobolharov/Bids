IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SubCategoryFiltered_ByStyleCategory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SubCategoryFiltered_ByStyleCategory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SubCategoryFiltered_ByStyleCategory_SELECT]
	@StyleCategoryID NVARCHAR(50)
	, @OrderBy NVARCHAR(200)
AS
BEGIN

	DECLARE @sqlQuery NVARCHAR(MAX)
	
	SET @sqlQuery = 'SELECT CustomID AS SubCategoryId, Custom AS SubCategory FROM pSubCategory sc ' +
					'INNER JOIN pStyleCategorySubCategory scsc ON sc.CustomID = scsc.SubCategoryId ' +
					'WHERE scsc.StyleCategoryId = @StyleCategoryID AND sc.Active = 1 '
						
	IF @OrderBy IS NOT NULL AND @OrderBy <> ''
	BEGIN
		SET @sqlQuery = @sqlQuery + 'ORDER BY ' + 'sc.' + REPLACE(@OrderBy, ',', ', sc.')
	END
	ELSE
	BEGIN
		SET @sqlQuery = @sqlQuery + 'ORDER BY CustomSort, Custom'
	END
	
	exec sp_executesql @sqlQuery,
		N'@StyleCategoryID nvarchar(50)',
		@StyleCategoryID = @StyleCategoryID	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08334', GetDate())
GO
