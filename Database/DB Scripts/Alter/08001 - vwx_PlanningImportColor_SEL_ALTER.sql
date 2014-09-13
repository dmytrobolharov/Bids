SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER VIEW [dbo].[vwx_PlanningImportColor_SEL]
AS
SELECT
	pssiy.PlanningID
	, pssy.SeasonYearID
	, pssiy.SeasonYearID AS ImportSeasonYearID
	, pci.PlanningColorID
	, pci.CUser
	, pci.CDate
	, pci.MUser
	, pci.MDate
	, pci.PlanningColorDrop
	, cp.ColorPaletteID
	, cp.ColorFolderID
	, '<a href=''../Color/Color_Folder.aspx?CT=1&CFID=' + CAST(cp.ColorFolderID AS nVARCHAR(50)) + ''' target=''_blank''>' + cf.ColorFolderDescription + '</a>' AS ColorPalette	
	, '<a href=''../Color/Color_Folder.aspx?CT=1&CFID=' + CAST(cp.ColorFolderID AS nVARCHAR(50)) + '&CPID=' + CAST(cp.ColorPaletteID AS nVARCHAR(50)) + ''' target=''_blank''>' + cp.ColorCode + '</a>' AS ColorCode	
	, cp.ColorName
	, cp.ColorSource
	, cp.ColorNotes
	, cp.Hex
	, cp.ColorImage
	, cp.ColorImageType
	, cp.CopyColorPaletteID
	, cp.Active
	, cp.Sort
	, cf.ColorTypeID
	, '../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(pci.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pci.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImageUrl
	, '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(pci.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pci.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath
	, cf.ColorFolderDescription
	, ct.ColorTypeDescription
	, cc.ColorClassID
	, cc.ColorClassName AS ColorClass
FROM pPlanningSeasonYear pssy
	INNER JOIN pPlanningSeasonYear pssiy ON pssiy.PlanningID = pssy.PlanningID AND pssy.SeasonYearID <> pssiy.SeasonYearID
	INNER JOIN pPlanningColor pci ON pssiy.PlanningID = pci.PlanningID AND pssiy.SeasonYearID = pci.SeasonYearID
	LEFT JOIN pPlanningColor pc ON pci.PlanningID = pc.PlanningID AND pssy.SeasonYearID = pc.SeasonYearID AND pci.ColorPaletteID = pc.ColorPaletteID
	INNER JOIN pColorPalette cp ON pci.ColorPaletteID = cp.ColorPaletteID
	INNER JOIN pColorFolder cf ON cp.ColorFolderID = cf.ColorFolderID
	LEFT JOIN pColorType ct ON cf.ColorTypeID = ct.ColorTypeID
	LEFT JOIN pColorClass cc ON cp.ColorClassID = cc.ColorClassID
WHERE pc.PlanningColorID IS NULL


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08001', GetDate())
GO
