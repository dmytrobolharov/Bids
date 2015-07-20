
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 28 June 2011                                                                                */
-- * WorkItem#2070                                                                                     */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonYear_PIVOT]    Script Date: 06/28/2011 13:52:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonYear_PIVOT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonYear_PIVOT]    Script Date: 06/28/2011 13:52:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonYear_PIVOT](@StyleId uniqueidentifier)
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
	<TD width=''16''><IMG src=''' + '' + CAST(ISNULL(pStyleColorwayStatus_1.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS VARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(pStyleColorwayStatus_1.Status,'900') AS VARCHAR(40)) + '''></TD>
	<TD width=''16''><IMG src=''' + '' + CAST(ISNULL(pStyleColorwayStatus_2.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS VARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(pStyleColorwayStatus_2.Status,'900') AS VARCHAR(40)) + '''></TD>
	<TD width=''16''><IMG src=''' + '' + CAST(ISNULL(pStyleColorwayStatus_3.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS VARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(pStyleColorwayStatus_3.Status,'900') AS VARCHAR(40)) + '''></TD>
	</TR></TABLE>' AS Color, 
	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
	<IMG src=''' + '../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(pColorPalette.ColorFolderID AS VARCHAR(40)) + 
	'&CPID=' + CAST(pColorPalette.ColorPaletteID AS VARCHAR(40)) + ''' border=0 ALT=''''></TD></TR></TABLE>' AS ColorUrl
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



SELECT c.StyleColorID, a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, f.SeasonYearID, 
	d.ColorCode as StyleColorNo, d.ColorName as StyleColorName , c.PLMCode, c.SAPCode,  
	f.Season + ' ' + f.Year AS SeasonYear, 

	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR>
	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery1 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS VARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS VARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>


	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery2 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS VARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS VARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	<TD width=''16''><IMG src=''' +  
		CASE WHEN a.StyleColorDelivery3 = 1 then 
			CAST(ISNULL(b.StatusIconUrl,'../System/icons/icon_tranparent.gif') AS VARCHAR(40)) + ''' border=0 ALT=''' + CAST(ISNULL(a.StyleColorStatus,'900') AS VARCHAR(40)) 
		ELSE
			'../System/icons/icon_tranparent.gif'' border=0 ALT=''900'''
		END
	+ '''></TD>

	</TR></TABLE>' AS Color, 	
	d.ColorFolderID,
	d.ColorPaletteID 

INTO #tmpStyleColorSeasonYear
FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleColorwayStatus b ON a.StyleColorStatus = b.StatusID
INNER JOIN pStyleColorway c ON a.StyleColorwayID = c.StyleColorID
INNER JOIN pColorPalette d ON d.ColorPaletteID  = c.ColorPaletteID 
INNER JOIN pStyleSeasonYear e ON e.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pSeasonYear  f ON e.SeasonYearID = f.SeasonYearID 
WHERE c.StyleID = @StyleID
ORDER BY SeasonYear


-- select * from #tmpStyleColorSeasonYear

EXECUTE spx_Crosstab 
'SELECT SeasonYear, Color, StyleColorNo, StyleColorName,ColorFolderID,ColorPaletteID FROM #tmpStyleColorSeasonYear',
NULL,
NULL,
'SeasonYear',
'Color',
'MAX'

DROP TABLE #tmpStyleColorSeasonYear
--DROP TABLE #StyleColorSeasonYear

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01632'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '01632', GetDate())
END	

GO

