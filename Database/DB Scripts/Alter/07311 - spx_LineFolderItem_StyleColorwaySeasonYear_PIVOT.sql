IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleColorwaySeasonYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleColorwaySeasonYear_PIVOT]
GO




CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleColorwaySeasonYear_PIVOT]
(
	@StyleId uniqueidentifier,
	@LineFolderItemID uniqueidentifier
)
AS 



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
	Color nVARCHAR (MAX) collate database_default,
	ColorFolderID UNIQUEIDENTIFIER,
	ColorPaletteID UNIQUEIDENTIFIER
)

-- select colors that were added on Colorway page
INSERT INTO #tmpStyleColorSeasonYear
SELECT c.StyleColorID, a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, f.SeasonYearID, 
	d.ColorCode as StyleColorNo, d.ColorName as StyleColorName , c.PLMCode, c.SAPCode,  
	f.Season + ' ' + f.Year AS SeasonYear, a.Sort,

	CASE WHEN sbca.StyleColorID IS NULL OR sbca.ColorActive = 1 THEN
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

	</TR></TABLE>' ELSE '<P ID=''Inactive''/>' END AS Color, 	
	d.ColorFolderID,
	d.ColorPaletteID 

FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleColorwayStatus b ON a.StyleColorStatus = b.StatusID
INNER JOIN pStyleColorway c ON a.StyleColorwayID = c.StyleColorID
INNER JOIN pColorPalette d ON d.ColorPaletteID  = c.ColorPaletteID 
INNER JOIN pStyleSeasonYear e ON e.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pSeasonYear  f ON e.SeasonYearID = f.SeasonYearID 
LEFT JOIN vwx_StyleBOMColor_SeasonalActivity_SEL sbca ON a.StyleColorwayID = sbca.StyleColorID AND a.StyleSeasonYearID = sbca.StyleSeasonYearID
WHERE c.StyleID = @StyleID
AND c.StyleColorID NOT IN (SELECT StyleColorID FROM pLineFolderItemColor WHERE LineFolderItemID = @LineFolderItemID AND StyleColorID IS NOT NULL)
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


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07311', GetDate())
GO
