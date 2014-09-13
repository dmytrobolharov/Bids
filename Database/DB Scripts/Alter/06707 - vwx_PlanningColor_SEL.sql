IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningColor_SEL]'))
DROP VIEW [dbo].[vwx_PlanningColor_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningColor_SEL]
AS
SELECT TOP (100) PERCENT dbo.pPlanningColor.PlanningColorID
	, dbo.pPlanningColor.PlanningID
	, dbo.pPlanningColor.CUser
	, dbo.pPlanningColor.CDate
	, dbo.pPlanningColor.MUser
	, dbo.pPlanningColor.MDate
	, dbo.pColorPalette.ColorPaletteID
	, dbo.pColorPalette.ColorFolderID
	, '<a href=''../Color/Color_Folder.aspx?CT=1&CFID=' + CAST(dbo.pColorPalette.ColorFolderID AS nVARCHAR(50)) + ''' target=''_blank''>' + dbo.pColorFolder.ColorFolderDescription + '</a>' AS ColorPalette	
	, '<a href=''../Color/Color_Folder.aspx?CT=1&CFID=' + CAST(dbo.pColorPalette.ColorFolderID AS nVARCHAR(50)) + '&CPID=' + CAST(dbo.pColorPalette.ColorPaletteID AS nVARCHAR(50)) + ''' target=''_blank''>' + dbo.pColorPalette.ColorCode + '</a>' AS ColorCode	
	, dbo.pColorPalette.ColorName
	, dbo.pColorPalette.ColorSource
	, dbo.pColorPalette.ColorNotes
	, dbo.pColorPalette.Hex
	, dbo.pColorPalette.ColorImage
	, dbo.pColorPalette.ColorImageType
	, dbo.pColorPalette.CopyColorPaletteID
	, dbo.pColorPalette.Active
	, dbo.pColorPalette.Sort
	, dbo.pColorFolder.ColorTypeID
	, dbo.pPlanningColor.PlanningColorDrop
	, dbo.pPlanningColor.PlanningColorDropUser
	, dbo.pPlanningColor.PlanningColorDropDate
	, '../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pPlanningColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pPlanningColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImageUrl
	, '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pPlanningColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pPlanningColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath
	, dbo.pPlanningColor.SeasonYearID
	, dbo.pColorFolder.ColorFolderDescription
	, dbo.pColorType.ColorTypeDescription
	, (
		SELECT COUNT(*)
		FROM dbo.pStyleColorwaySeasonYear
		INNER JOIN dbo.pStyleSeasonYear ON dbo.pStyleColorwaySeasonYear.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
		WHERE dbo.pColorPalette.ColorPaletteID = dbo.pStyleColorwaySeasonYear.ColorPaletteID
			AND dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID
		) AS IsBOMUsed
FROM dbo.pColorPalette
	INNER JOIN dbo.pPlanningColor ON dbo.pColorPalette.ColorPaletteID = dbo.pPlanningColor.ColorPaletteID
	INNER JOIN dbo.pColorFolder ON dbo.pColorPalette.ColorFolderID = dbo.pColorFolder.ColorFolderID
	LEFT JOIN dbo.pColorType ON dbo.pColorFolder.ColorTypeID = dbo.pColorType.ColorTypeID
ORDER BY dbo.pColorPalette.ColorName
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06707', GetDate())
GO
