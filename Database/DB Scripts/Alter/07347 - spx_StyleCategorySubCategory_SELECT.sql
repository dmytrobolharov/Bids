IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCategorySubCategory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCategorySubCategory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCategorySubCategory_SELECT](
	@StyleCategoryId UNIQUEIDENTIFIER
	)
AS
BEGIN
	SELECT SubCategoryId FROM pStyleCategorySubCategory WHERE StyleCategoryId = @StyleCategoryId
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07347', GetDate())
GO
