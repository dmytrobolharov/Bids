IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @MerchFin TABLE(FinancialID UNIQUEIDENTIFIER)
	INSERT INTO @MerchFin(FinancialID)
	VALUES ('10000000-0000-0000-0000-000000000000') /* # of Planned Styles */
		, ('10000000-0000-0000-0000-000000000019') /* # of Planned Colorways */
		, ('10000000-0000-0000-0000-000000000020') /* # of Over Dev. Styles */
		, ('10000000-0000-0000-0000-000000000001') /* # of Carry Over Styles */
		, ('10000000-0000-0000-0000-000000000004') /* Projected Wholesale Units */
		, ('10000000-0000-0000-0000-000000000005') /* Projected Retail Units */
		, ('10000000-0000-0000-0000-000000000021') /* Projected Ecom Units */
		, ('10000000-0000-0000-0000-000000000022') /* Total Projected Units */

	-- import values from planning
	-- maybe replace with MERGE in case of performance issues
	DELETE FROM pLineFolderMerchandiseBusiness WHERE LineFolderID = @LineFolderID
	INSERT INTO pLineFolderMerchandiseBusiness(
		PlanningID, LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
		PlanningStyleCategoryID, PlanningStyleCategory, SeasonYearID,
		PlanningPlanningCh, PlanningDIPCh, PlanningActualCh)
	SELECT lf.PlanningID, @LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
		PlanningStyleCategoryID, PlanningStyleCategory, pb.SeasonYearID,
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh 
	FROM pLineFolder lf
	INNER JOIN pLineFolderStyleType lfst ON lf.LineFolderID = lfst.LineFolderID
	INNER JOIN pStyleCategoryStyleType scst ON lfst.StyleTypeID = scst.StyleTypeID
	INNER JOIN pLineFolderStyleCategory lfsc ON scst.StyleCategoryID = lfsc.StyleCategoryID 
		AND lfst.LineFolderID = lfsc.LineFolderID
	INNER JOIN pPlanningBusiness pb ON lf.PlanningID = pb.PlanningID AND lf.SeasonYearID = pb.SeasonYearID
		AND lf.LineFolderDivisionID = pb.PlanningDivisionID
		AND lfst.StyleTypeID = pb.PlanningStyleTypeID
		AND lfsc.StyleCategoryID = pb.PlanningStyleCategoryID
		AND pb.PlanningSubCategoryID IS NULL
	INNER JOIN @MerchFin mf ON pb.PlanningFinancialID = mf.FinancialID
	WHERE lf.LineFolderID = @LineFolderID AND pb.Active = 1
	UNION ALL
	SELECT lf.PlanningID, @LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
		PlanningStyleCategoryID, PlanningStyleCategory, pb.SeasonYearID,
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh 
	FROM pLineFolder lf
	INNER JOIN pLineFolderStyleType lfst ON lf.LineFolderID = lfst.LineFolderID
	INNER JOIN pPlanningBusiness pb ON lf.PlanningID = pb.PlanningID AND lf.SeasonYearID = pb.SeasonYearID
		AND lf.LineFolderDivisionID = pb.PlanningDivisionID 
		AND lfst.StyleTypeID = pb.PlanningStyleTypeID
		AND pb.PlanningStyleCategoryID IS NULL
	INNER JOIN @MerchFin mf ON pb.PlanningFinancialID = mf.FinancialID
	WHERE lf.LineFolderID = @LineFolderID AND pb.Active = 1
	UNiON ALL
	SELECT lf.PlanningID, @LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
		PlanningStyleCategoryID, PlanningStyleCategory, pb.SeasonYearID,
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh
	FROM pLineFolder lf
	INNER JOIN pPlanningBusiness pb ON lf.PlanningID = pb.PlanningID AND lf.SeasonYearID = pb.SeasonYearID 
		AND lf.LineFolderDivisionID = pb.PlanningDivisionID AND pb.PlanningStyleTypeID IS NULL
	INNER JOIN @MerchFin mf ON pb.PlanningFinancialID = mf.FinancialID
	WHERE lf.LineFolderID = @LineFolderID AND pb.Active = 1
	UNION ALL
	SELECT lf.PlanningID, @LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
		PlanningStyleCategoryID, PlanningStyleCategory, pb.SeasonYearID,
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh
	FROM pLineFolder lf
	INNER JOIN pPlanningBusiness pb ON lf.PlanningID = pb.PlanningID AND lf.SeasonYearID = pb.SeasonYearID 
		AND pb.PlanningBrandID IS NULL AND pb.PlanningDivisionID IS NULL
	INNER JOIN @MerchFin mf ON pb.PlanningFinancialID = mf.FinancialID
	WHERE lf.LineFolderID = @LineFolderID AND pb.Active = 1

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09116', GetDate())
GO
