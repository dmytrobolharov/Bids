IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCategorySubCategory_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCategorySubCategory_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleCategorySubCategory_DELETE](
	@StyleCategoryId UNIQUEIDENTIFIER,
	@SubCategoryId UNIQUEIDENTIFIER
	)
AS
BEGIN
	DELETE FROM pStyleCategorySubCategory WHERE StyleCategoryId = @StyleCategoryId AND SubCategoryId = @SubCategoryId
	AND (SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory WHERE PlanningStyleCategoryID = @StyleCategoryId AND SubCategoryID = @SubCategoryId) = 0
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07345', GetDate())
GO
