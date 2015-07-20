/****** Object:  StoredProcedure [dbo].[spx_Style_Component_Where]    Script Date: 06/01/2010 11:19:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[spx_Style_Component_Where](
@MaterialID uniqueidentifier,
@MaterialVersion int,
@TeamID UNIQUEIDENTIFIER ,
@FieldSeason varchar (100), 
@FieldYear varchar (100)

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



SELECT a.StyleSeasonYearID , a.StyleID ,c.StyleNo ,c.DesignSketchVersion, 
	c.DesignSketchID,c.SizeClass,c.SizeRange,c.Description,c.MaterialName,
	c.CustomField2,c.CustomField4
FROM pStyleSeasonYear a 
	INNER JOIN #tmp b ON a.StyleID = b.StyleID 
	INNER JOIN pStyleHeader c ON c.StyleID = b.StyleID 

DROP TABLE #tmp

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '117', GetDate())

GO