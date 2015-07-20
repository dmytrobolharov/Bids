IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_MaterialFolder_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_MaterialFolder_WHERECount_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_MaterialFolder_WHERECount_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @MaterialTypeID NVARCHAR(MAX)
)
AS

DECLARE @MaterialCount INT
DECLARE @ColorCount INT
DECLARE @StyleCount INT
DECLARE @SupplierCount INT
DECLARE @CountryCount INT
DECLARE @OpenSubmitCount INT
DECLARE @LateSubmitCount INT
DECLARE @ApprovedSubmitCount INT

SET @MaterialCount = 0
SET @ColorCount = 0
SET @StyleCount = 0
SET @SupplierCount = 0
SET @CountryCount = 0
SET @OpenSubmitCount = 0
SET @LateSubmitCount = 0
SET @ApprovedSubmitCount = 0

IF @SeasonYearID IS NULL
	OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN
	SELECT TOP 1 @SeasonYearID = SeasonYearID
	FROM pSeasonYear
	WHERE CurrentSeason = 1
END

DECLARE @tmpMaterialType TABLE (MaterialTypeID INT)
INSERT INTO @tmpMaterialType
SELECT CAST(value AS INT) FROM fnx_Split(@MaterialTypeID, ',')

-- Get Total # of Material
BEGIN
	SET @MaterialCount = (
			SELECT COUNT(*) AS MaterialCount
			FROM pMaterial
			INNER JOIN pMaterialSeasonYear ON pMaterial.MaterialID = pMaterialSeasonYear.MaterialID
			INNER JOIN pSeasonYear ON pMaterialSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
			INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
			WHERE (pMaterialSeasonYear.SeasonYearID = @SeasonYearID)
			GROUP BY pMaterialSeasonYear.SeasonYearID
			)
END

-- Get Total # of Color
BEGIN
	SET @ColorCount = (
			SELECT COUNT(*) AS MaterialColorCount
			FROM dbo.pMaterialColorSeasonYear
			INNER JOIN dbo.pMaterial ON dbo.pMaterialColorSeasonYear.MaterialID = dbo.pMaterial.MaterialID
			INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
			WHERE (dbo.pMaterialColorSeasonYear.SeasonYearID = @SeasonYearID)
			GROUP BY dbo.pMaterialColorSeasonYear.SeasonYearID
			)
END

-- Get Total # of Style
BEGIN
	SET @StyleCount = (
			SELECT COUNT(*) AS StyleCount
			FROM pStyleHeader
			INNER JOIN pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID
			INNER JOIN pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
			WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
				AND pStyleHeader.StyleID IN (
					SELECT StyleID
					FROM pStyleMaterials
					INNER JOIN dbo.pMaterialSeasonYear ON dbo.pStyleMaterials.MaterialID = dbo.pMaterialSeasonYear.MaterialID
					INNER JOIN pMaterial ON pStyleMaterials.MaterialID = pMaterial.MaterialID
					INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
					WHERE (dbo.pMaterialSeasonYear.SeasonYearID = @SeasonYearID)
					UNION
					SELECT StyleID FROM pStyleBOM
					INNER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
					INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
					INNER JOIN dbo.pMaterialSeasonYear ON dbo.pStyleBOM.MaterialID = dbo.pMaterialSeasonYear.MaterialID
					WHERE (dbo.pMaterialSeasonYear.SeasonYearID = @SeasonYearID)
					)
			)
END

-- Get Total # of Supplier
BEGIN
	SET @SupplierCount = (
			SELECT COUNT(*) AS SupplierCount
			FROM pMaterial
			INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
			INNER JOIN dbo.pMaterialSeasonYear ON dbo.pMaterial.MaterialID = dbo.pMaterialSeasonYear.MaterialID
			INNER JOIN dbo.pSeasonYear ON dbo.pMaterialSeasonYear.SeasonYearID = dbo.pSeasonYear.SeasonYearID
			INNER JOIN dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId
			WHERE (dbo.pMaterialSeasonYear.SeasonYearID = @SeasonYearID)
			GROUP BY dbo.pMaterialSeasonYear.SeasonYearID
			)
END

-- Get Total # of Open Submit
BEGIN
	SET @OpenSubmitCount = (
			SELECT COUNT(*) AS SubmitCount
			FROM dbo.pMaterial
			INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
			INNER JOIN dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId
			INNER JOIN dbo.pMaterialRequestSubmitWorkflow ON dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID
			INNER JOIN dbo.pMaterialRequestSubmit ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
				AND dbo.pMaterialRequestSubmitWorkflow.Submit = dbo.pMaterialRequestSubmit.Submit
			WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)
				AND (
					pMaterialRequestSubmit.STATUS = 1
					OR pMaterialRequestSubmit.STATUS = 0
					)
			)
END

-- Get Total # of Approved Submit
BEGIN
	SET @ApprovedSubmitCount = (
			SELECT COUNT(*) AS SubmitCount
			FROM dbo.pMaterial
			INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
			INNER JOIN dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId
			INNER JOIN dbo.pMaterialRequestSubmitWorkflow ON dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID
			INNER JOIN dbo.pMaterialRequestSubmit ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
				AND dbo.pMaterialRequestSubmitWorkflow.Submit = dbo.pMaterialRequestSubmit.Submit
			WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)
				AND (
					pMaterialRequestSubmit.STATUS = 2
					OR pMaterialRequestSubmit.STATUS = 3
					)
			)
END

-- Get Total # of Late Submit
BEGIN
	SET @LateSubmitCount = (
			SELECT COUNT(*) AS SubmitCount
			FROM dbo.pMaterial
			INNER JOIN @tmpMaterialType mt ON pMaterial.MaterialType = mt.MaterialTypeID
			INNER JOIN dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId
			INNER JOIN dbo.pMaterialRequestSubmitWorkflow ON dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID
			INNER JOIN dbo.pMaterialRequestSubmit ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
				AND dbo.pMaterialRequestSubmitWorkflow.Submit = dbo.pMaterialRequestSubmit.Submit
			WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)
				AND (
					pMaterialRequestSubmit.STATUS = 1
					OR pMaterialRequestSubmit.STATUS = 0
					)
				AND pMaterialRequestSubmit.DueDate <= GETDATE()
			)
END

BEGIN
	CREATE TABLE #tmpMaterialCount (
		MaterialCount INT NULL
		, ColorCount INT NULL
		, StyleCount INT NULL
		, SupplierCount INT NULL
		, CountryCount INT NULL
		, OpenSubmitCount INT NULL
		, LateSubmitCount INT NULL
		, ApprovedSubmitCount INT NULL
		)
END

BEGIN
	INSERT INTO #tmpMaterialCount (
		MaterialCount
		, ColorCount
		, StyleCount
		, SupplierCount
		, CountryCount
		, OpenSubmitCount
		, LateSubmitCount
		, ApprovedSubmitCount
		)
	VALUES (
		@MaterialCount
		, @ColorCount
		, @StyleCount
		, @SupplierCount
		, @CountryCount
		, @OpenSubmitCount
		, @LateSubmitCount
		, @ApprovedSubmitCount
		)
END

BEGIN
	SELECT TOP 1 *
	FROM #tmpMaterialCount
END

BEGIN
	DROP TABLE #tmpMaterialCount
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08836', GetDate())
GO
