IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AvaliableSubCategoryList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_AvaliableSubCategoryList_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_AvaliableSubCategoryList_SELECT](
	@StyleCategoryId UNIQUEIDENTIFIER
	)
AS
BEGIN

	SELECT CustomId AS SubCategoryId, Custom AS SubCategory
    FROM pSubCategory
	WHERE CustomID NOT IN (SELECT SubCategoryId FROM pStyleCategorySubCategory WHERE StyleCategoryId = @StyleCategoryId) AND Active = 1
	ORDER BY SubCategory
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07343', GetDate())
GO
