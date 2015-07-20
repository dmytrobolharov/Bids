IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Component_Where]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Component_Where]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_Style_Component_Where](
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
WHERE a.MaterialID =  @MaterialID
and MChange =  @MaterialVersion
UNION
SELECT DISTINCT StyleID
FROM pStyleBOM a
WHERE a.MaterialID =  @MaterialID
and MChange =  @MaterialVersion



SELECT a.StyleSeasonYearID , a.StyleID ,c.StyleNo,c.DesignSketchVersion, @MaterialVersion as MChange, c.StyleSet,
	'MaterialWhere_Customer.xml' as CustomSchema, 'spx_Style_Custom_Where' as CustomStoredProc,
	@MaterialID as MaterialID,
	c.DesignSketchID,c.SizeClass,c.SizeRange,c.Description,c.MaterialName,
	c.CustomField2,c.CustomField4
FROM pStyleSeasonYear a 
	INNER JOIN #tmp b ON a.StyleID = b.StyleID 
	INNER JOIN pStyleHeader c ON c.StyleID = b.StyleID 

DROP TABLE #tmp


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03141'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03141', GetDate())

END
GO