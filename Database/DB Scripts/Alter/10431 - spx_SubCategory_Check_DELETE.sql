/****** Object:  StoredProcedure [dbo].[spx_SubCategory_Check_DELETE]    Script Date: 03/27/2015 17:27:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SubCategory_Check_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SubCategory_Check_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_SubCategory_Check_DELETE](
	@SubCategoryID UNIQUEIDENTIFIER
)
AS
BEGIN

IF EXISTS (SELECT * FROM pStyleHeader WHERE SubCategoryId = CAST(@SubCategoryID AS NVARCHAR(50)))
	OR EXISTS (SELECT * FROM pPlanningBusiness WHERE PlanningSubCategoryID = @SubCategoryID)
	OR EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory WHERE SubCategoryId = @SubCategoryID)
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
VALUES ('DB_Version', '6.1.0000', '10431', GetUTCDate())
GO
