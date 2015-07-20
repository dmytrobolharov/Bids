IF OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowColor_Add_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_Add_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_Add_SELECT] (
	@MaterialTradePartnerID UNIQUEIDENTIFIER
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
	)
AS
DECLARE @SeasonYearID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER

SELECT @SeasonYearID = SeasonYearID
	, @MaterialID = MaterialID
FROM pMaterialTradePartner
WHERE MaterialTradePartnerID = @MaterialTradePartnerID

SELECT
	ISNULL(b.MaterialSizeID, '00000000-0000-0000-0000-000000000000') AS MaterialSizeID
	, CASE 
		WHEN b.MaterialSizeID IS NULL
			THEN '*NA'
		ELSE b.MaterialSize
		END AS MaterialSize
	, CAST(ISNULL(b.MaterialSizeID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '/' + CAST(a.MaterialColorID AS NVARCHAR(50)) AS MaterialColorSizeID
	, CASE 
		WHEN c.MaterialColorImageID IS NULL
			THEN 
			  '<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0"><TR><TD width="18">'+
			  dbo.fnx_GetStreamingColorImageHTML(c.ColorFolderID, c.ColorPaletteID, 16, 'border="0" alt="Open"') + 
		      '</TD></TR></TABLE>'
		    ELSE 
		      '<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0"><TR><TD width="18">'+
			  dbo.fnx_GetStreamingImageHTML(c.MaterialColorImageID, c.MaterialColorImageVersion, 16, 'border="0" alt="Open"') +
		      '</TD></TR></TABLE>'
		END AS ColorImagePath
	, c.ColorName
	, a.MaterialColorID
FROM pMaterialColorSeasonYear a
INNER JOIN pMaterialColor c ON a.MaterialColorID = c.MaterialColorID
LEFT OUTER JOIN (SELECT MaterialSize, MaterialSizeID, MaterialID FROM pMaterialSize UNION SELECT NULL AS MaterialSize, NULL AS MaterialSizeID, @MaterialID AS MaterialID) b ON a.MaterialID = b.MaterialID
WHERE a.MaterialID = @MaterialID
	AND a.SeasonYearID = @SeasonYearID
	AND CAST(ISNULL(b.MaterialSizeID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '/' + CAST(a.MaterialColorID AS NVARCHAR(50)) NOT IN (
		SELECT CAST(ISNULL(a.MaterialSizeID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '/' + CAST(a.MaterialColorID AS NVARCHAR(50)) AS MaterialColorSizeID
		FROM pMaterialTradePartnerColor a
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID
		)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10372', GetUTCDate())
GO
