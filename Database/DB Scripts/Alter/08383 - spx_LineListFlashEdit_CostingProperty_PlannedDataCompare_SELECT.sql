IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashEdit_CostingProperty_PlannedDataCompare_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashEdit_CostingProperty_PlannedDataCompare_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineListFlashEdit_CostingProperty_PlannedDataCompare_SELECT]
	@LineFolderID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN

DECLARE @PlanningID UNIQUEIDENTIFIER,
		@SeasonYearID UNIQUEIDENTIFIER

SELECT @PlanningID = PlanningID, @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID


IF @StyleID IS NULL
BEGIN
	SELECT 
		@StyleID as StyleID
		,NULL as DivisionID
		,NULL as StyleTypeID
		,NULL as StyleCategoryID
		,NULL as SubCategoryID
		,NULL as Planned_AvgCostUnit
		,NULL as Planned_AvgWSUnit
		,NULL as Planned_WSUnits
		,NULL as Planned_AvgRUnit
		,NULL as Planned_RUnits
		,NULL as Planned_AvgEUnit
		,NULL as Planned_EUnits
		,NULL as DeltaWSUnits
		,NULL as DeltaRUnits
		,NULL as DeltaEUnits
	FROM pStyleHeader WHERE 1=2
	RETURN
END

;WITH StyleCostSum AS (
	SELECT 
		SUM(sch.StyleCostingCustomField6) as WSUnits
		,SUM(sch.StyleCostingCustomField7) as RTUnits
		,SUM(sch.StyleCostingCustomField5) as EUnits 
	FROM pLineFolderItem lfi
		INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
		INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pLineFolderItem lfi2 
			INNER JOIN pStyleHeader sh2 ON lfi2.StyleID = sh2.StyleID
			INNER JOIN pStyleSeasonYear ssy2 ON lfi2.StyleSeasonYearID = ssy2.StyleSeasonYearID
		ON lfi.LineFolderID = lfi2.LineFolderID --AND ssy.SeasonYearID = ssy2.SeasonYearID
			AND sh.DivisionID = sh2.DivisionID 
			AND sh.StyleType = sh2.StyleType 
			AND sh.StyleCategory = sh2.StyleCategory 
			--AND ISNULL(sh.SubCategoryId,'') = ISNULL(sh2.SubCategoryId,'')
		LEFT JOIN pStyleCostingHeader sch ON lfi2.StyleSeasonYearID = sch.StyleSeasonYearID
		WHERE lfi.StyleID = @StyleID AND lfi.LineFolderID = @LineFolderID --AND ssy.SeasonYearID = @SeasonYearID
), PlannedData AS (
SELECT DivisionID, StyleType as StyleTypeID, StyleCategory as StyleCategoryID, SubCategoryId
	,[10000000-0000-0000-0000-000000000006] as Planned_AvgCostUnit
	,[10000000-0000-0000-0000-000000000007] as Planned_AvgWSUnit
	,[10000000-0000-0000-0000-000000000004] as Planned_WSUnits
	,[10000000-0000-0000-0000-000000000008] as Planned_AvgRUnit
	,[10000000-0000-0000-0000-000000000005] as Planned_RUnits
	,[10000000-0000-0000-0000-000000000023] as Planned_AvgEUnit
	,[10000000-0000-0000-0000-000000000021] as Planned_EUnits
FROM (
SELECT sh.DivisionID, sh.StyleType, sh.StyleCategory, sh.SubCategoryId, pf.PlanningFinancialID, pb.PlanningPlanningCh 
FROM pStyleHeader sh
	LEFT JOIN pPlanningBusiness pb
	ON pb.PlanningID = @PlanningID 
	AND pb.SeasonYearID = @SeasonYearID 
	AND sh.DivisionID = pb.PlanningDivisionID
	AND sh.StyleType = pb.PlanningStyleTypeID
	AND sh.StyleCategory = pb.PlanningStyleCategoryID
	AND pb.PlanningSubCategoryID IS NULL
	--AND (CASE WHEN sh.SubCategoryId IS NULL OR sh.SubCategoryId = '' THEN '00000000-0000-0000-0000-000000000000' 
	--	ELSE sh.SubCategoryId END = 
	--	ISNULL(pb.PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000') 
	--		OR (LEN(ISNULL(sh.SubCategoryId,''))>0 AND pb.PlanningSubCategoryID IS NULL AND 
	--			sh.SubCategoryId NOT IN (SELECT PlanningSubCategoryID FROM pPlanningStyleCategoryToSubCategory psctsc
	--					WHERE psctsc.PlanningID = @PlanningID
	--					AND psctsc.SeasonYearID = @SeasonYearID
	--					AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
	--					AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
	--					AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID)
	--			)
	--	)
	AND pb.PlanningFinancialID IN (
		'10000000-0000-0000-0000-000000000006'
		,'10000000-0000-0000-0000-000000000007'
		,'10000000-0000-0000-0000-000000000004'
		,'10000000-0000-0000-0000-000000000008'
		,'10000000-0000-0000-0000-000000000005'
		,'10000000-0000-0000-0000-000000000023'
		,'10000000-0000-0000-0000-000000000021'
		)
	LEFT JOIN pPlanningFinancial pf ON pb.PlanningFinancialID = pf.PlanningFinancialID
WHERE StyleID = @StyleID 
) pvt PIVOT(MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (
			[10000000-0000-0000-0000-000000000006],
			[10000000-0000-0000-0000-000000000007],
			[10000000-0000-0000-0000-000000000004],
			[10000000-0000-0000-0000-000000000008],
			[10000000-0000-0000-0000-000000000005],
			[10000000-0000-0000-0000-000000000023],
			[10000000-0000-0000-0000-000000000021])) fin
)
SELECT @StyleID as StyleID
	,PlannedData.* 
	,(Planned_WSUnits - ISNULL(WSUnits,0)) as DeltaWSUnits 
	,(Planned_RUnits - ISNULL(RTUnits,0)) as DeltaRUnits 
	,(Planned_EUnits - ISNULL(EUnits,0)) as DeltaEUnits 
FROM PlannedData 
	CROSS JOIN StyleCostSum


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08383', GetDate())
GO
