IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineList_Allocate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineList_Allocate]
GO


CREATE PROCEDURE [dbo].[spx_Planning_LineList_Allocate]
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @CUser NVARCHAR (200)
	, @CDate DATETIME
	, @TeamID UNIQUEIDENTIFIER = NULL
AS
BEGIN

	DECLARE @ConfigLevel INT
	SELECT DISTINCT @ConfigLevel = (CASE WHEN StyleCategoryID IS NOT NULL THEN 3 WHEN StyleTypeID IS NOT NULL THEN 2 WHEN DivisionID IS NOT NULL THEN 1 ELSE 0 END) FROM pPlanningLineListConfig WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID

	CREATE TABLE #tmpLineListResult (LineFolderID UNIQUEIDENTIFIER)

	CREATE TABLE #tmpExistingLineListConfigurations (
		LineFolderID UNIQUEIDENTIFIER		
		, DivisionID UNIQUEIDENTIFIER
		, StyleTypeID NVARCHAR(MAX)
		, StyleCategoryID NVARCHAR(MAX)
	)
	
	CREATE TABLE #tmpExistingPlanningConfigurations (
		PlanningConfigID UNIQUEIDENTIFIER
		, DivisionID UNIQUEIDENTIFIER
		, StyleTypeID NVARCHAR(MAX)
		, StyleCategoryID NVARCHAR(MAX)
	)

	INSERT INTO #tmpExistingLineListConfigurations
	SELECT LineFolderID, LineFolderDivisionID, StyleTypeID, StyleCategoryID
	FROM vwx_LineFolder_Header_SEL
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
	
	IF @ConfigLevel = 1
		INSERT INTO #tmpExistingPlanningConfigurations
		SELECT DISTINCT pllc.PlanningConfigID, pllc.DivisionID,
		STUFF((SELECT ', ' + CAST(stype.StyleTypeID AS NVARCHAR(MAX))
			FROM (SELECT DISTINCT st.StyleTypeID FROM pStyleType st
				INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
				INNER JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID AND stt.StyleTypeTemplateName = 'Style'
				INNER JOIN pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
			WHERE pPlanningDivision.DivisionID = pllc.DivisionID) stype
			ORDER BY stype.StyleTypeID
			FOR XML PATH('')), 1, 2, '') AS StyleTypes,
		STUFF((SELECT ', ' + CAST(scategory.StyleCategoryID AS NVARCHAR(MAX))
			FROM (SELECT DISTINCT sc.StyleCategoryId FROM pStyleCategory sc
				INNER JOIN pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID
				INNER JOIN pDivisionStyleType dst ON scst.StyleTypeID = dst.StyleTypeID
				INNER JOIN pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
			WHERE pPlanningDivision.DivisionID = pllc.DivisionID) scategory
			ORDER BY scategory.StyleCategoryId
			FOR XML PATH('')), 1, 2, '') AS StyleCategories
		FROM pPlanningLineListConfig pllc
		WHERE pllc.PlanningID = @PlanningID AND pllc.SeasonYearID = @SeasonYearID
	ELSE IF @ConfigLevel = 2
		INSERT INTO #tmpExistingPlanningConfigurations
		SELECT DISTINCT pllc.PlanningConfigID, pllc.DivisionID, pllc.StyleTypeID,
		STUFF(
			(SELECT ', ' + CAST(scategory.StyleCategoryID AS NVARCHAR(MAX)) 
			FROM (SELECT DISTINCT sc.StyleCategoryId FROM pStyleCategory sc
				INNER JOIN pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID
			WHERE scst.StyleTypeID = pllc.StyleTypeID) scategory
			ORDER BY scategory.StyleCategoryId
			FOR XML PATH('')), 1, 2, '') AS StyleCategories
		FROM pPlanningLineListConfig pllc
		WHERE pllc.PlanningID = @PlanningID	AND pllc.SeasonYearID = @SeasonYearID
	ELSE IF @ConfigLevel = 3
		INSERT INTO #tmpExistingPlanningConfigurations
		SELECT DISTINCT pllc.PlanningConfigID, pllc.DivisionID, pllc.StyleTypeID, pllc.StyleCategoryID
		FROM pPlanningLineListConfig pllc
		WHERE pllc.PlanningID = @PlanningID AND pllc.SeasonYearID = @SeasonYearID
	
	SELECT sh.StyleID, sh.DivisionID, sh.StyleType, sh.StyleCategory, pli.PlanningItemID
	INTO #tmpAvailableStyles
	FROM pStyleHeader sh 
		INNER JOIN pPlanningItem pli ON sh.StyleID = pli.StyleID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
		AND pli.StyleID NOT IN (SELECT StyleID FROM pLineFolderItem lfi INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID AND lf.PlanningID = @PlanningID)
	
	SELECT DISTINCT PlanningConfigID, epc.DivisionID, epc.StyleTypeID, epc.StyleCategoryID, LineFolderID,
		CASE WHEN EXISTS (SELECT * FROM #tmpAvailableStyles tas WHERE tas.DivisionID = epc.DivisionID AND tas.StyleType = sst.StyleTypeID AND tas.StyleCategory = ssc.StyleCategoryID) THEN 1 ELSE 0 END AS CreateLineList
	INTO #tmpConfigurationsToCreate
	FROM #tmpExistingPlanningConfigurations epc
	CROSS APPLY (SELECT CAST(LTRIM(RTRIM(value)) AS INT) FROM dbo.fnx_Split(epc.StyleTypeID, ',')) as sst(StyleTypeID)
	CROSS APPLY (SELECT CAST(LTRIM(RTRIM(value)) AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(epc.StyleCategoryID, ',')) as ssc(StyleCategoryID)
	LEFT JOIN #tmpExistingLineListConfigurations elc ON elc.DivisionID = epc.DivisionID AND elc.StyleTypeID = epc.StyleTypeID AND elc.StyleCategoryID = epc.StyleCategoryID 
	
	DELETE FROM #tmpConfigurationsToCreate WHERE (LineFolderID IS NULL AND CreateLineList = 0) OR (LineFolderID IS NOT NULL AND CreateLineList = 1)
	
	DECLARE @PlanningConfigID UNIQUEIDENTIFIER
	DECLARE @DivisionID UNIQUEIDENTIFIER
	DECLARE @StyleTypeID NVARCHAR(MAX)
	DECLARE @StyleCategoryID NVARCHAR(MAX)
	DECLARE @LineFolderID UNIQUEIDENTIFIER
	DECLARE @CreateLineList INT

	DECLARE @StyleROW INT
	DECLARE @StyleTotal INT
			
	DECLARE c CURSOR READ_ONLY FOR SELECT * FROM #tmpConfigurationsToCreate
	OPEN c
	
	FETCH NEXT FROM c INTO @PlanningConfigID, @DivisionID, @StyleTypeID, @StyleCategoryID, @LineFolderID, @CreateLineList
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @LineFolderID IS NULL AND @CreateLineList = 1
			BEGIN
				SET @LineFolderID = NEWID()
				EXEC spx_Planning_LineFolder_INSERT @PlanningID, @SeasonYearID, @LineFolderID, @CDate, @CUser
				EXEC spx_LineFolderStyleTypes_DELETE_INSERT @LineFolderID, @StyleTypeID
				EXEC spx_LineFolderStyleCategories_DELETE_INSERT @LineFolderID, @StyleCategoryID
				UPDATE pLineFolder SET
					LineFolderDivisionID = @DivisionID
					, LineFolderDescription = pllc.LineFolderDescription
					, LineListTypeID = pllc.LineListTypeID
					, LineSubFolder6 = DATEADD(DAY, pllc.Days, @CDate)
				FROM (SELECT LineFolderDescription, LineListTypeID, Days FROM pPlanningLineListConfig WHERE PlanningConfigID = @PlanningConfigID) pllc
				WHERE pLineFolder.LineFolderID = @LineFolderID
				INSERT INTO #tmpLineListResult VALUES (@LineFolderID)
			END
		
		SELECT IDENTITY(int, 1, 1) AS rowid, tas.PlanningItemID, tas.StyleID
		INTO #StyleTable
		FROM #tmpAvailableStyles tas
			INNER JOIN pLineFolder lf ON tas.DivisionID = lf.LineFolderDivisionID
			INNER JOIN pLineFolderStyleType lfst ON lf.LineFolderID = lfst.LineFolderID AND tas.StyleType = lfst.StyleTypeID
			INNER JOIN pLineFolderStyleCategory lfsc ON lf.LineFolderID = lfsc.LineFolderID AND tas.StyleCategory = lfsc.StyleCategoryID
		WHERE lf.LineFolderID = @LineFolderID
		
		SET @StyleROW = 1
		SET @StyleTotal = (SELECT COUNT(*) FROM #StyleTable)
		
		WHILE @StyleROW <= @StyleTotal
		BEGIN
			DECLARE @PlanningItemID UNIQUEIDENTIFIER = (SELECT PlanningItemID FROM #StyleTable WHERE ROWID = @StyleROW)
			DECLARE @StyleID UNIQUEIDENTIFIER = (SELECT StyleID FROM #StyleTable WHERE ROWID = @StyleROW)
			DECLARE @StyleNo NVARCHAR(100) = (SELECT StyleNo FROM pStyleHeader WHERE StyleID = @StyleID)
			EXEC spx_LineFolder_Allocation_PlanningItem_INSERT @LineFolderID, @PlanningItemId, @CUser, @CDate	
			
			-- Notification for Line List (Style XXX was added to this Line List from the Line Plan)
			DECLARE @PlanningActivityTypeID UNIQUEIDENTIFIER = (SELECT PlanningActivityTypeID FROM pPlanningActivityType WHERE PlanningActivityKey = 'SAL')
			EXEC spx_PlanningActivity_INSERT 
					@PlanningID = @PlanningID, 
					@SeasonYearID = @SeasonYearID, 
					@StyleID = @StyleID,
					@TeamID = @TeamID,
					@CreatedBy = @CUser,
					@CreatedDate = @CDate,
					@PlanningActivityTypeID = @PlanningActivityTypeID,
					@ParamValues = @StyleNo
		
			SET @StyleROW = @StyleROW + 1
		END	
		DROP TABLE #StyleTable
		
		FETCH NEXT FROM c INTO @PlanningConfigID, @DivisionID, @StyleTypeID, @StyleCategoryID, @LineFolderID, @CreateLineList
	END
	CLOSE c
	DEALLOCATE c

	SELECT * FROM #tmpLineListResult

	DROP TABLE #tmpLineListResult
	DROP TABLE #tmpConfigurationsToCreate
	DROP TABLE #tmpAvailableStyles
	DROP TABLE #tmpExistingLineListConfigurations
	DROP TABLE #tmpExistingPlanningConfigurations
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07953', GetDate())
GO
