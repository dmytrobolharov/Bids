IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCategory_Check_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCategory_Check_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleCategory_Check_DELETE](
	@StyleCategoryID UNIQUEIDENTIFIER
)
AS
BEGIN

IF EXISTS (SELECT * FROM pStyleHeader WHERE StyleCategory = @StyleCategoryID)
	OR EXISTS (SELECT * FROM pPlanningBusiness WHERE PlanningStyleCategoryID = @StyleCategoryID)
	OR EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory WHERE PlanningStyleCategoryID = @StyleCategoryID)
BEGIN
	SELECT 1
END
ELSE
BEGIN
	SELECT 0
END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08953', GetDate())
GO
