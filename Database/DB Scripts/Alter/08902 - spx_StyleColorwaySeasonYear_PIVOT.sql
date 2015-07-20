IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonYear_PIVOT]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonYear_PIVOT] (
	@StyleId uniqueidentifier
)
AS 


/*

select  a.StyleSeasonYearID, a.StyleColorwayID, a.StyleColorwaySeasonYearID,
	case when StyleColorDelivery1 = 1 then StyleColorStatus	else 900 end as StyleColorDelivery1,
	case when StyleColorDelivery2 = 1 then StyleColorStatus	else 900 end as StyleColorDelivery2,
	case when StyleColorDelivery3 = 1 then StyleColorStatus else 900 end as StyleColorDelivery3,
	case when StyleColorDelivery4 = 1 then StyleColorStatus	else 900 end as StyleColorDelivery4
INTO #StyleColorSeasonYear
from pStyleColorwaySeasonYear a
where a.StyleID = @StyleID


SELECT pStyleColorway.StyleColorID, #StyleColorSeasonYear.StyleColorwaySeasonYearID, pStyleSeasonYear.StyleSeasonYearID, pSeasonYear.SeasonYearID, 
	pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, pStyleColorway.PLMCode, pStyleColorway.SAPCode,  
	pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYear, 
	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR>
	<TD width=''16''><IMG src=''' + '' + CAST(ISNULL(pStyleColorwayStatus_1.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(pStyleColorwayStatus_1.Status,'900') AS nVARCHAR(40)) + '''></TD>
	<TD width=''16''><IMG src=''' + '' + CAST(ISNULL(pStyleColorwayStatus_2.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(pStyleColorwayStatus_2.Status,'900') AS nVARCHAR(40)) + '''></TD>
	<TD width=''16''><IMG src=''' + '' + CAST(ISNULL(pStyleColorwayStatus_3.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(pStyleColorwayStatus_3.Status,'900') AS nVARCHAR(40)) + '''></TD>
	</TR></TABLE>' AS Color, 
	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
	<IMG src=''' + '../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(pColorPalette.ColorFolderID AS nVARCHAR(40)) + 
	'&CPID=' + CAST(pColorPalette.ColorPaletteID AS nVARCHAR(40)) + ''' border=0 ALT=''''></TD></TR></TABLE>' AS ColorUrl
INTO #tmpStyleColorSeasonYear
FROM pStyleColorwayStatus AS pStyleColorwayStatus_1 RIGHT OUTER JOIN
  pStyleColorwayStatus AS pStyleColorwayStatus_2 RIGHT OUTER JOIN
  pStyleSeasonYear INNER JOIN
  #StyleColorSeasonYear ON pStyleSeasonYear.StyleSeasonYearID = #StyleColorSeasonYear.StyleSeasonYearID INNER JOIN
  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID LEFT OUTER JOIN
  pStyleColorwayStatus AS pStyleColorwayStatus_3 ON #StyleColorSeasonYear.StyleColorDelivery3 = pStyleColorwayStatus_3.StatusID ON 
  pStyleColorwayStatus_2.StatusID = #StyleColorSeasonYear.StyleColorDelivery2 RIGHT OUTER JOIN
  pStyleColorway ON #StyleColorSeasonYear.StyleColorwayID = pStyleColorway.StyleColorID LEFT OUTER JOIN
  pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID ON 
  pStyleColorwayStatus_1.StatusID = #StyleColorSeasonYear.StyleColorDelivery1
WHERE pStyleColorway.StyleID = @StyleID
ORDER BY SeasonYear
*/


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
	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' height=''100%'' border=''0''><TR>
	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery1 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.Units,'') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>


	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery2 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.Units,'') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery3 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.Units,'') AS nVARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery4 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS nVARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.Units,'') AS nVARCHAR(40)) 
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
ORDER BY SeasonYear


--select * from #tmpStyleColorSeasonYear


DECLARE @cols NVARCHAR(2000)
DECLARE @query NVARCHAR(4000)

select @cols = COALESCE(@cols + ',[' +  cast(g.Season + ' ' + g.Year as nvarchar(100)) + ']',
						 '[' +  cast(g.Season + ' ' + g.Year as nvarchar(100)) + ']') from 
(select distinct f.Season, f.Year  from pStyleColorwaySeasonYear a
INNER JOIN pStyleSeasonYear e ON e.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pSeasonYear  f ON e.SeasonYearID = f.SeasonYearID 
WHERE a.StyleID = @StyleID) as g		

SET @query = N'SELECT SAPCode, PLMCode, StyleColorNo, StyleColorName, ColorFolderID, ColorPaletteID' + ISNULL(', '+@cols,'') + '
		FROM
		(SELECT SAPCode, PLMCode, SeasonYear, Color, StyleColorNo, StyleColorName, ColorFolderID, ColorPaletteID FROM #tmpStyleColorSeasonYear) p
		PIVOT
		(
			MAX(Color) FOR SeasonYear IN ( '+ ISNULL(@cols,'___') +' )
		) AS pvt
		ORDER BY StyleColorNo;'
--print(@query)	
execute(@query)	

--EXECUTE spx_Crosstab 
--'SELECT SAPCode, PLMCode, SeasonYear, Color, StyleColorNo, StyleColorName,ColorFolderID,ColorPaletteID FROM #tmpStyleColorSeasonYear',
--NULL,
--NULL,
--'SeasonYear',
--'Color',
--'MAX',
--NULL,
--NULL,
--NULL,
--NULL,
--NULL,
--'StyleColorNo'

DROP TABLE #tmpStyleColorSeasonYear
--DROP TABLE #StyleColorSeasonYear

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08902', GetDate())
GO
