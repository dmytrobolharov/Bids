IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowColor_Add_SELECT]') AND type in (N'P', N'PC'))
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
			THEN '<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
		<IMG src=''' + '../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(c.ColorFolderID AS VARCHAR(40)) + '&CPID=' + CAST(c.ColorPaletteID AS VARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
		ELSE '<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
		<IMG src=''' + '../System/Control/ImageStream.ashx?S=16&V=' + CAST(c.MaterialColorImageVersion AS VARCHAR(40)) + '&IID=' + CAST(c.MaterialColorImageID AS VARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
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
VALUES ('DB_Version', '0.5.0000', '06160', GetDate())
GO
