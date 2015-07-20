IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHeaderStyleCategories_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHeaderStyleCategories_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingHeaderStyleCategories_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SelectedStyleTypes VARCHAR(MAX) = ''
AS
BEGIN
	
	SELECT DISTINCT sc.StyleCategoryID, sc.StyleCategory,
	IsChecked = CASE
	WHEN shsc.StyleCategoryID IS NULL THEN 'FALSE'
	ELSE 'TRUE'
	END,
	IsEnabled = CASE
	WHEN EXISTS(SELECT * FROM pSourcingStyle ss INNER JOIN pStyleHeader sh ON ss.StyleID = sh.StyleID 
				WHERE sh.StyleCategory = sc.StyleCategoryID AND ss.SourcingHeaderID = @SourcingHeaderID) 
	THEN 'FALSE' ELSE 'TRUE' 
	END
    FROM pStyleCategory sc INNER JOIN pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID
	LEFT JOIN pSourcingHeaderToStyleCategory shsc ON shsc.StyleCategoryID = sc.StyleCategoryId AND shsc.SourcingHeaderID = @SourcingHeaderID
    WHERE scst.StyleTypeID IN (SELECT LTRIM(RTRIM(value)) FROM dbo.fnx_Split(@SelectedStyleTypes, ','))
	ORDER BY sc.StyleCategory

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06124', GetDate())
GO
