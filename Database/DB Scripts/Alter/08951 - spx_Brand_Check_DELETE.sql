IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Brand_Check_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Brand_Check_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_Brand_Check_DELETE](
	@BrandID UNIQUEIDENTIFIER
)
AS
BEGIN

IF EXISTS (SELECT * FROM iCustom1 WHERE BrandID = @BrandID)
	OR EXISTS (SELECT * FROM pBrandDelivery WHERE BrandID = @BrandID)
	OR EXISTS (SELECT * FROM pPlanningBusiness WHERE PlanningBrandID = @BrandID)
	OR EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory WHERE PlanningBrandID = @BrandID)
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
VALUES ('DB_Version', '6.0.0000', '08951', GetDate())
GO
