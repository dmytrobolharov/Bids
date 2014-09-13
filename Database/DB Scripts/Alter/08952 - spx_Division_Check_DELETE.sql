IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Division_Check_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Division_Check_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_Division_Check_DELETE](
	@DivisionID UNIQUEIDENTIFIER
)
AS
BEGIN

IF EXISTS (SELECT * FROM pStyleHeader WHERE DivisionID = @DivisionID)
	OR EXISTS (SELECT * FROM pPlanningBusiness WHERE PlanningDivisionID = @DivisionID)
	OR EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory WHERE PlanningDivisionID = @DivisionID)
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
VALUES ('DB_Version', '6.0.0000', '08952', GetDate())
GO
