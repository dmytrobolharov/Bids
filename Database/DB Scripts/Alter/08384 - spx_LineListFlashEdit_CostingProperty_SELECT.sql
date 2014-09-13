IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashEdit_CostingProperty_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashEdit_CostingProperty_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineListFlashEdit_CostingProperty_SELECT]
	@LineFolderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	DECLARE @PlanningID UNIQUEIDENTIFIER,
			@SeasonYearID UNIQUEIDENTIFIER

	SELECT @PlanningID = PlanningID, @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	-- select planning styles to temp table
	SELECT *, NULL as NegativeDelta 
	INTO #tmpStyles	
	FROM vwx_LineListFlashEdit_CostingProperty_SELECT WHERE LineFolderID = @LineFolderID
	
	-- calculate NegativeDelta Column
	;WITH StyleCostSum AS (
	SELECT 
		lfi.StyleID, sh.DivisionID, sh.StyleType as StyleTypeID, sh.StyleCategory as StyleCategoryID, sh.SubCategoryId
		,SUM(sch.StyleCostingCustomField6) as WSUnits
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
		WHERE lfi.LineFolderID = @LineFolderID --AND ssy.SeasonYearID = @SeasonYearID
	GROUP BY lfi.StyleID, sh.DivisionID, sh.StyleType, sh.StyleCategory, sh.SubCategoryId
	), PlannedData AS (
	SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID
		,[10000000-0000-0000-0000-000000000006] as Planned_AvgCostUnit
		,[10000000-0000-0000-0000-000000000007] as Planned_AvgWSUnit
		,[10000000-0000-0000-0000-000000000004] as Planned_WSUnits
		,[10000000-0000-0000-0000-000000000008] as Planned_AvgRUnit
		,[10000000-0000-0000-0000-000000000005] as Planned_RUnits
		,[10000000-0000-0000-0000-000000000023] as Planned_AvgEUnit
		,[10000000-0000-0000-0000-000000000021] as Planned_EUnits
	FROM (
	SELECT pb.PlanningDivisionID, pb.PlanningStyleTypeID, pb.PlanningStyleCategoryID, pb.PlanningSubCategoryID, pb.PlanningFinancialID, pb.PlanningPlanningCh 
	FROM pPlanningBusiness pb 
	WHERE pb.PlanningID = @PlanningID AND pb.SeasonYearID = @SeasonYearID
		AND pb.PlanningFinancialID IN (
			'10000000-0000-0000-0000-000000000006'
			,'10000000-0000-0000-0000-000000000007'
			,'10000000-0000-0000-0000-000000000004'
			,'10000000-0000-0000-0000-000000000008'
			,'10000000-0000-0000-0000-000000000005'
			,'10000000-0000-0000-0000-000000000023'
			,'10000000-0000-0000-0000-000000000021'
			)
	) pvt PIVOT(MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (
				[10000000-0000-0000-0000-000000000006],
				[10000000-0000-0000-0000-000000000007],
				[10000000-0000-0000-0000-000000000004],
				[10000000-0000-0000-0000-000000000008],
				[10000000-0000-0000-0000-000000000005],
				[10000000-0000-0000-0000-000000000023],
				[10000000-0000-0000-0000-000000000021])) fin

	)
	UPDATE #tmpStyles
	SET NegativeDelta = CASE WHEN (Planned_WSUnits - WSUnits) < 0 OR (Planned_RUnits - RTUnits) < 0 OR (Planned_EUnits - EUnits) < 0 THEN 1 ELSE 0 END
	FROM StyleCostSum as sh
		INNER JOIN PlannedData pb
		ON sh.DivisionID = pb.PlanningDivisionID
		AND sh.StyleTypeID = pb.PlanningStyleTypeID
		AND sh.StyleCategoryID = pb.PlanningStyleCategoryID
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
	WHERE #tmpStyles.StyleID = sh.StyleID

	-- result select for grid
	EXEC('SELECT * FROM #tmpStyles ' + @SearchCond + ' order by LineFolderItemSort, StyleNo ' )
	
	-- count of style with NegativeDelta = 1
	EXEC('SELECT COUNT(*) FROM #tmpStyles WHERE NegativeDelta = 1' )

	DROP TABLE #tmpStyles

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08384', GetDate())
GO
