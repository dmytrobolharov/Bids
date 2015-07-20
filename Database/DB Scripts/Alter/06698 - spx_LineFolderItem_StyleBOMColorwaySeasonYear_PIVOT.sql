IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleBOMColorwaySeasonYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorwaySeasonYear_PIVOT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorwaySeasonYear_PIVOT]
(
	@StyleId uniqueidentifier,
	@LineFolderItemID uniqueidentifier,
	@StyleBOMDimensionID uniqueidentifier
)
AS 

IF @StyleBOMDimensionID IS NOT NULL
BEGIN

CREATE TABLE #tmpStyleColorSeasonYear(
	StyleColorID UNIQUEIDENTIFIER,
	StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
	StyleSeasonYearID UNIQUEIDENTIFIER,
	SeasonYearID UNIQUEIDENTIFIER,
	StyleColorNo NVARCHAR (200) collate database_default,
	StyleColorName NVARCHAR (200) collate database_default,
	PLMCode NVARCHAR (200) collate database_default,
	SAPCode NVARCHAR (200) collate database_default,
	SeasonYear NVARCHAR (200) collate database_default,
	Sort INT,
	Color nVARCHAR (8000) collate database_default,
	ColorFolderID UNIQUEIDENTIFIER,
	ColorPaletteID UNIQUEIDENTIFIER
)

-- select colors that were added on Colorway page
INSERT INTO #tmpStyleColorSeasonYear
SELECT c.StyleColorID, a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, f.SeasonYearID, 
	d.ColorCode as StyleColorNo, d.ColorName as StyleColorName , c.PLMCode, c.SAPCode,  
	f.Season + ' ' + f.Year AS SeasonYear, a.Sort,

	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR>
	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery1 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>


	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery2 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery3 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery4 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	</TR></TABLE>' AS Color, 	
	d.ColorFolderID,
	d.ColorPaletteID 

FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleColorwayStatus b ON a.StyleColorStatus = b.StatusID
INNER JOIN pStyleColorway c ON a.StyleColorwayID = c.StyleColorID
INNER JOIN pColorPalette d ON d.ColorPaletteID  = c.ColorPaletteID 
INNER JOIN pStyleSeasonYear e ON e.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pSeasonYear  f ON e.SeasonYearID = f.SeasonYearID 
WHERE c.StyleID = @StyleID
AND d.ColorPaletteID NOT IN (
	SELECT ColorPaletteID
	FROM pStyleBOMDimensionItem 
		INNER JOIN pColorPalette ON COALESCE(ItemDim1Id, ItemDim2Id, ItemDim3Id, '00000000-0000-0000-0000-000000000000') = ColorPaletteID
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID
)
ORDER BY SeasonYear

-- select colors that were added from Dim BOM
INSERT INTO #tmpStyleColorSeasonYear
SELECT NULL as StyleColorID, a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, f.SeasonYearID, 
	d.ColorCode as StyleColorNo, d.ColorName as StyleColorName , ISNULL(sh.StyleNo,'') + d.ColorCode as PLMCode, NULL as SAPCode,  
	f.Season + ' ' + f.Year AS SeasonYear, a.Sort,

	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR>
	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery1 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>


	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery2 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery3 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery4 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	</TR></TABLE>' AS Color, 	
	d.ColorFolderID,
	d.ColorPaletteID 

FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleColorwayStatus b ON a.StyleColorStatus = b.StatusID
INNER JOIN pColorPalette d ON d.ColorPaletteID  = a.ColorPaletteID 
INNER JOIN pStyleSeasonYear e ON e.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pSeasonYear  f ON e.SeasonYearID = f.SeasonYearID 
INNER JOIN pStyleHeader sh ON a.StyleID = sh.StyleID
WHERE a.StyleID = @StyleID AND a.ColorPaletteID IS NOT NULL
AND a.ColorPaletteID NOT IN (
	SELECT ColorPaletteID
	FROM pStyleBOMDimensionItem 
		INNER JOIN pColorPalette ON COALESCE(ItemDim1Id, ItemDim2Id, ItemDim3Id, '00000000-0000-0000-0000-000000000000') = ColorPaletteID
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID
)
ORDER BY SeasonYear

--select * from #tmpStyleColorSeasonYear

EXECUTE spx_Crosstab 
'SELECT StyleColorID, SAPCode, PLMCode, SeasonYear, Color, StyleColorNo, StyleColorName,ColorFolderID,ColorPaletteID FROM #tmpStyleColorSeasonYear',
NULL,
NULL,
'SeasonYear',
'Color',
'MAX',
NULL,
NULL,
NULL,
NULL,
NULL,
'StyleColorNo'

DROP TABLE #tmpStyleColorSeasonYear

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06698', GetDate())
GO
