IF OBJECT_ID(N'[dbo].[spx_LinePlanShowroom_PIVOT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanShowroom_PIVOT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanShowroom_PIVOT] 
(
 @LinePlanRangeID UNIQUEIDENTIFIER ,
 @Filter NVARCHAR(4000)
)
AS



DECLARE @tableX  NVARCHAR(50)
DECLARE @tableTmp NVARCHAR(50)
DECLARE @tableName NVARCHAR(50)
DECLARE @Season NVARCHAR(50)
DECLARE @Year NVARCHAR(50)
DECLARE @DUMMY UNIQUEIDENTIFIER 

select  @Season = b.Season , @Year  = b.Year 
from pLinePlanRange  a
INNER JOIN pLinePlan b ON a.LinePlanID = b.LinePlanID  
WHERE LinePlanRangeID = @LinePlanRangeID


SET @tableX = '##' + REPLACE(CAST ( NEWID()AS NVARCHAR (50)), '-', '')
SET @tableTmp = '##' + REPLACE(CAST ( NEWID()AS NVARCHAR (50)), '-', '')
SET @tableName = '##' + REPLACE(CAST ( NEWID()AS NVARCHAR (50)), '-', '')
SET @DUMMY =  NULL



DECLARE @TMPSQL NVARCHAR(4000)

SET @TMPSQL = 'SELECT a.LinePlanRangeID, a.ShowroomID, a.Qty, a.StyleID, b.Custom as Showroom, a.StyleColorID, 
c.StyleNo, c.Description, d.StyleColorName, d.StyleColorNo, c.MaterialName,
dbo.fnx_GetStreamingColorImageHTML(e.ColorFolderID, e.ColorPaletteID, 20, '''') AS ColorPath,
0 as Units, a.Price as Cost, 0 as TotalCost, a.TradePartnerVendorID,
dbo.fnx_GetStreamingImageHTML(c.DesignSketchID, c.DesignSketchVersion, 50, '''') AS StyleImagePath,
f.LinePlanStyleAttributeItemID, o.StyleColorwaySeasonYearID
into ' +  @tableX + '
FROM pLinePlanShowroomStyleColor  a
INNER JOIN pShowroom b ON a.ShowroomID = b.CustomID 
INNER JOIN pStyleHeader c ON c.StyleID =  a.StyleID  
INNER JOIN pStyleColorway d ON d.StylecolorID = a.StylecolorID 
INNER JOIN pColorPalette e ON e.ColorPaletteID  = d.ColorPaletteID
INNER JOIN pLinePlanItem f ON f.StyleID = c.StyleID  AND f.LinePlanRangeID = a.LinePlanRangeID 
INNER JOIN pLinePlanShowroomItem m ON m.LinePlanRangeID = a.LinePlanRangeID AND m.ShowroomID = a.ShowroomID
INNER JOIN pStyleSeasonYear n ON n.StyleID = f.StyleID AND n.LinePlanItemID =  f.LinePlanItemID 
INNER JOIN pStyleColorwaySeasonYear o ON o.StyleSeasonYearID =  n.StyleSeasonYearID  AND o.StyleColorwayID = d.StyleColorID
WHERE a.LinePlanRangeID = ''' +  CAST( @LinePlanRangeID  AS NVARCHAR(50)) + '''  '


IF LEN (@Filter) > 0 
BEGIN
	SET @Filter  = REPLACE (@Filter, 'LinePlanRangeID'  , 'a.LinePlanRangeID' )
	SET @Filter  = REPLACE (@Filter, 'Description'  , 'c.Description' )
	SET @TMPSQL = @TMPSQL +  ' AND ' + @Filter
END 


PRINT @TMPSQL  
--PRINT ' '
--PRINT ' '

EXEC sp_executesql @TMPSQL 

SET @TMPSQL = '
SELECT  a.*, g.AttributeName,  h.MaterialCode 
INTO '  + @tableTmp  + '
FROM ' + @tableX  + ' a
LEFT OUTER JOIN pLinePlanStyleAttributeItem g ON g.LinePlanStyleAttributeItemID = a.LinePlanStyleAttributeItemID
LEFT OUTER JOIN pStyleMaterials i ON i.StyleID = a.StyleID AND i.MainMaterial = 1
LEFT OUTER JOIN pMaterial h ON h.MaterialID = i.MaterialID
'

EXEC sp_executesql @TMPSQL 
SET @TMPSQL = 'DROP TABLE ' + @tableX 


SET @TMPSQL = 'SELECT Qty, ShowroomID, StyleID, StyleColorID, StyleNo, Description, StyleColorName, StyleColorNo, MaterialCode, MaterialName, ColorPath,
Units, Cost, TotalCost, TradePartnerVendorID, StyleImagePath, LinePlanRangeID, AttributeName,StyleColorwaySeasonYearID
FROM ' + @tableTmp

EXECUTE spx_Crosstab 
@DBFetch = @TMPSQL,
@DBWhere = NULL,
@DBPivot = NULL,
@DBField = 'ShowroomID',
@PCField = 'Qty',
@PCBuild = 'MAX',
@PCAdmin = NULL,
@DBAdmin = 0,
@DBTable = @tableName ,
@DBWrite = NULL,
@DBUltra = 0



SET @TMPSQL = 'DROP TABLE ' + @tableTmp 
EXEC sp_executesql @TMPSQL 


DECLARE @SQL AS NVARCHAR(300) 

set  @sql = 'ALTER TABLE ' +  @tableName  + ' ADD ROW_ID INT NOT NULL IDENTITY(1,1) ' 
--PRINT @sql 
EXEC sp_executesql @sql 


DECLARE @TOTAL INT
DECLARE @ROW_ID INT 
DECLARE @ParmDefinition nvarchar(500)
DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleColorID UNIQUEIDENTIFIER
DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER
DECLARE @UNITS INT
--DECLARE @Rate MONEY 
DECLARE @Cost MONEY 

SET @SQL = 'SELECT @pTOTAL = COUNT(*) FROM  ' + @tableName   
SET @ParmDefinition = '@pTotal INT OUTPUT'
EXECUTE sp_executesql @SQL, @ParmDefinition, @pTotal = @Total OUTPUT

SET @ROW_ID = 1



WHILE  @ROW_ID <= @Total 
BEGIN

	
		--set @Rate =  0 

		SET @SQL = 'SELECT @pStyleID  = StyleID, @pStyleColorID = StyleColorID, @pTradePartnerVendorID = TradePartnerVendorID, @pCost = Cost
		FROM ' + @tableName + '	WHERE ROW_ID = ' + Cast (@ROW_ID as NVARCHAR(5))
		SET @ParmDefinition = '@pStyleID UNIQUEIDENTIFIER OUTPUT, @pStyleColorID UNIQUEIDENTIFIER OUTPUT, @pTradePartnerVendorID UNIQUEIDENTIFIER OUTPUT, @pCost MONEY OUTPUT'
		EXECUTE sp_executesql @SQL, @ParmDefinition, @pStyleID = @StyleID OUTPUT, @pStyleColorID = @StyleColorID OUTPUT,  @pTradePartnerVendorID = @TradePartnerVendorID OUTPUT, @pCost = @Cost OUTPUT

		
		
		SELECT @UNITS = SUM (Qty)
		FROM  pLinePlanShowroomStyleColor a
		INNER JOIN pLinePlanShowroomItem b ON a.ShowroomID = b.ShowroomID AND a.LinePlanRangeID = b.LinePlanRangeID 
		INNER JOIN pShowroom c ON a.ShowroomID = c.CustomID
		WHERE a.StyleID = @StyleID AND a.StyleColorID =  @StyleColorID 
		AND a.LinePlanRangeID = @LinePlanRangeID 



		SET @SQL = 'UPDATE  ' + @tableName + ' SET  ' +  --Cost = ' + CAST (@Rate AS NVARCHAR(50)) +  ', ' +
		' Units = ' + CAST (@UNITS AS NVARCHAR(50))  +  ', ' +
		' TotalCost = '+  CAST ((@UNITS * ISNULL(@Cost,0) ) AS  NVARCHAR(50)) +
		' WHERE ROW_ID = ' + CAST (@ROW_ID AS NVARCHAR(50))
		
		EXECUTE sp_executesql @SQL
		
		SET @ROW_ID = @ROW_ID + 1

END 



set  @sql = 'SELECT * FROM  ' + @tableName  + ' ORDER BY StyleNo, Description, StyleColorName, CAST (StyleColorID AS NVARCHAR(50)) ; DROP TABLE ' + @tableName 
PRINT @sql 

EXEC sp_executesql @sql 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10360', GetUTCDate())
GO
