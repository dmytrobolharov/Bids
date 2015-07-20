IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SelectedSubCategoryList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SelectedSubCategoryList_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SelectedSubCategoryList_SELECT](
	@StyleCategoryId UNIQUEIDENTIFIER
	)
AS
BEGIN
	SELECT CustomId AS SubCategoryId, Custom AS SubCategory
    FROM pSubCategory sc
    INNER JOIN pStyleCategorySubCategory scsc ON sc.CustomID = scsc.SubCategoryId
    WHERE scsc.StyleCategoryId = @StyleCategoryId AND sc.Active = 1
    ORDER BY SubCategory
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07344', GetDate())
GO
