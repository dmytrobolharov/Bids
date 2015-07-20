
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Component_Where]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Component_Where]
GO

CREATE PROCEDURE [dbo].[spx_Style_Component_Where](
@MaterialID uniqueidentifier,
@MaterialVersion int,
@FieldSeason varchar (100), 
@FieldYear varchar (100),
@TeamID UNIQUEIDENTIFIER 
)

AS 

CREATE TABLE #tmp (
	StyleID UNIQUEIDENTIFIER 
)

INSERT INTO #tmp (StyleID)
SELECT DISTINCT StyleID 
FROM pStyleMaterials a
WHERE a.MaterialID =  @MaterialID -- 
and MChange =  @MaterialVersion -- 


SELECT a.StyleSeasonYearID , a.StyleID ,c.StyleNo ,c.DesignSketchVersion, c.DesignSketchID 
FROM pStyleSeasonYear a 
INNER JOIN #tmp b ON a.StyleID = b.StyleID 
INNER JOIN pStyleHeader c ON c.StyleID = b.StyleID 


DROP TABLE #tmp



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '063', GetDate())

GO
