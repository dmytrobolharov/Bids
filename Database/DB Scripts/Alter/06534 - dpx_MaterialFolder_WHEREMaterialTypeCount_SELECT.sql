IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_MaterialFolder_WHEREMaterialTypeCount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_MaterialFolder_WHEREMaterialTypeCount_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_MaterialFolder_WHEREMaterialTypeCount_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL,
	@MaterialTypeID int = NULL
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


IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END


-- Get Total # of Material
BEGIN
	SET @MaterialCount = (SELECT  COUNT(*) AS MaterialCount FROM  pMaterial INNER JOIN
	  pMaterialSeasonYear ON pMaterial.MaterialID = pMaterialSeasonYear.MaterialID INNER JOIN
	  pSeasonYear ON pMaterialSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
	GROUP BY pMaterialSeasonYear.SeasonYearID, pMaterial.MaterialType
	HAVING (pMaterial.MaterialType = @MaterialTypeID) AND (pMaterialSeasonYear.SeasonYearID = @SeasonYearID))
END

-- Get Total # of Color
BEGIN
	SET @ColorCount = (SELECT COUNT(*) AS MaterialColorCount
	FROM dbo.pMaterialColorSeasonYear INNER JOIN
	  dbo.pMaterial ON dbo.pMaterialColorSeasonYear.MaterialID = dbo.pMaterial.MaterialID
	GROUP BY dbo.pMaterial.MaterialType, dbo.pMaterialColorSeasonYear.SeasonYearID
	HAVING  (dbo.pMaterial.MaterialType = @MaterialTypeID) AND (dbo.pMaterialColorSeasonYear.SeasonYearID = @SeasonYearID))

END

-- Get Total # of Style
BEGIN
	SET @StyleCount = (
			SELECT COUNT(mat.StyleID) AS StyleCount
			FROM (SELECT MaterialID, StyleID, MaterialType FROM dbo.pStyleMaterials UNION SELECT MaterialID, StyleID, MaterialType FROM dbo.pStyleBOM) AS mat
			INNER JOIN dbo.pMaterialSeasonYear ON mat.MaterialID = dbo.pMaterialSeasonYear.MaterialID
			INNER JOIN dbo.pStyleHeader ON mat.StyleID = dbo.pStyleHeader.StyleID
			WHERE dbo.pMaterialSeasonYear.SeasonYearID = @SeasonYearID AND mat.MaterialType = @MaterialTypeID
			)
END


-- Get Total # of Supplier
BEGIN
	SET @SupplierCount = (SELECT COUNT(*) AS SupplierCount FROM dbo.pMaterial INNER JOIN
	dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId
	WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID) AND (dbo.pMaterial.MaterialType = @MaterialTypeID)
	GROUP BY dbo.pMaterialTradePartner.SeasonYearID, dbo.pMaterial.MaterialType
)
END

-- Get Total # of Open Submit
BEGIN
	SET @OpenSubmitCount = (
							SELECT COUNT(*) AS SubmitCount
							FROM  dbo.pMaterial INNER JOIN
								  dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId INNER JOIN
								  dbo.pMaterialRequestSubmitWorkflow ON 
								  dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID INNER JOIN
								  dbo.pMaterialRequestSubmit ON 
								  dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID AND 
								  dbo.pMaterialRequestSubmitWorkflow.Submit = dbo.pMaterialRequestSubmit.Submit
							WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)  AND (dbo.pMaterial.MaterialType = @MaterialTypeID)	
							AND (pMaterialRequestSubmit.Status = 1 OR pMaterialRequestSubmit.Status = 0)
)
END


-- Get Total # of Approved Submit
BEGIN
	SET @ApprovedSubmitCount = (
							SELECT COUNT(*) AS SubmitCount
							FROM  dbo.pMaterial INNER JOIN
								  dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId INNER JOIN
								  dbo.pMaterialRequestSubmitWorkflow ON 
								  dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID INNER JOIN
								  dbo.pMaterialRequestSubmit ON 
								  dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID AND 
								  dbo.pMaterialRequestSubmitWorkflow.Submit = dbo.pMaterialRequestSubmit.Submit
							WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)  AND (dbo.pMaterial.MaterialType = @MaterialTypeID)	
							AND (pMaterialRequestSubmit.Status = 2 OR pMaterialRequestSubmit.Status = 3)
)
END

-- Get Total # of Late Submit
BEGIN
	SET @LateSubmitCount = (
							SELECT COUNT(*) AS SubmitCount
							FROM  dbo.pMaterial INNER JOIN
								  dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId INNER JOIN
								  dbo.pMaterialRequestSubmitWorkflow ON 
								  dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID INNER JOIN
								  dbo.pMaterialRequestSubmit ON 
								  dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID AND 
								  dbo.pMaterialRequestSubmitWorkflow.Submit = dbo.pMaterialRequestSubmit.Submit
							WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)  AND (dbo.pMaterial.MaterialType = @MaterialTypeID)	
									AND (pMaterialRequestSubmit.Status = 1 OR pMaterialRequestSubmit.Status = 0)
									AND pMaterialRequestSubmit.DueDate <= GETDATE()
)
END

BEGIN
	CREATE TABLE #tmpMaterialCount(
		MaterialCount int NULL,
		ColorCount int NULL,
		StyleCount int NULL,
		SupplierCount int NULL,
		CountryCount int NULL,
		OpenSubmitCount int NULL,
		LateSubmitCount int NULL,
		ApprovedSubmitCount int NULL
	) 
END

BEGIN
	INSERT INTO #tmpMaterialCount(MaterialCount, ColorCount, StyleCount, SupplierCount, CountryCount, OpenSubmitCount, LateSubmitCount, ApprovedSubmitCount)
		VALUES (@MaterialCount, @ColorCount, @StyleCount, @SupplierCount, @CountryCount, @OpenSubmitCount, @LateSubmitCount, @ApprovedSubmitCount)
END

BEGIN
	SELECT TOP 1 * FROM #tmpMaterialCount
END

BEGIN
	DROP TABLE #tmpMaterialCount
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06534', GetDate())
GO
