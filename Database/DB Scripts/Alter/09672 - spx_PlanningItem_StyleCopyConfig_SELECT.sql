IF OBJECT_ID(N'[dbo].[spx_PlanningItem_StyleCopyConfig_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_PlanningItem_StyleCopyConfig_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_StyleCopyConfig_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(400),
	@CDate DATETIME
AS
BEGIN
	
	SELECT 1 AS LinkImage,
	N'UPDATE sh SET sh.DivisionID = cpsh.DivisionID, sh.StyleType = cpsh.StyleType, sh.StyleCategory = cpsh.StyleCategory, sh.StyleSet = 1,
        sh.SubCategoryId = cpsh.SubCategoryId, sh.SizeClass = cpsh.SizeClass, sh.SizeClassId = cpsh.SizeClassId, 
        sh.SizeRange = cpsh.SizeRange, sh.SizeRangeId = cpsh.SizeRangeId, sh.TechPackDate = cpsh.TechPackDate, 
        sh.CustomField3 = cpsh.CustomField3, sh.Active = cpsh.Active,
        sh.StyleStatus = ''Development'', sh.CUser = N''' + @CUser + ''', sh.CDate = N''' + CAST(@CDate AS NVARCHAR(400)) + ''', 
        sh.MUser = N''' + @CUser + ''', sh.MDate = N''' + CAST(@CDate AS NVARCHAR(400)) + ''', sh.IntroSeasonYearID = ''' + CAST(@SeasonYearID AS nVARCHAR(40)) + '''
    FROM pStyleHeader sh
    INNER JOIN pStyleHeader cpsh ON cpsh.StyleID = ''' + CAST(@StyleID AS nVARCHAR(40)) + '''
    WHERE sh.StyleID = ''12345678-0000-000-0000-ABCDEFGHIJKL''' AS SqlStyleHeaderUpdate
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09672', GetDate())
GO