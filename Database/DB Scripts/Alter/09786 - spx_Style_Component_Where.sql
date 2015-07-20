IF OBJECT_ID(N'[dbo].[spx_Style_Component_Where]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_Style_Component_Where]
GO

CREATE PROCEDURE [dbo].[spx_Style_Component_Where](
@MaterialID uniqueidentifier,
@MaterialVersion int,
@TeamID UNIQUEIDENTIFIER ,
@FieldSeason nvarchar (100), 
@FieldYear nvarchar (100)

)

AS 


SELECT * FROM (	
	SELECT a.StyleSeasonYearID , a.StyleID ,c.StyleNo,c.DesignSketchVersion, @MaterialVersion as MChange, c.StyleSet,
	'MaterialWhere_Customer.xml' as CustomSchema, 'spx_Style_Custom_Where' as CustomStoredProc,
	@MaterialID as MaterialID, c.DesignSketchID,
	COALESCE(sc.Custom, c.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, c.SizeRange) AS SizeRange,
	c.Description,c.MaterialName,
	c.CustomField2,c.CustomField4, a.SeasonYearID
FROM pStyleSeasonYear a 
	INNER JOIN pStyleMaterials b ON a.StyleID = b.StyleID
	INNER JOIN pStyleHeader c ON c.StyleID = b.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = c.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = c.SizeRangeId
	WHERE b.MaterialID = @MaterialID and MChange =  @MaterialVersion
UNION
	SELECT b.StyleSeasonYearID , a.StyleID ,c.StyleNo,c.DesignSketchVersion, @MaterialVersion as MChange, c.StyleSet,
	'MaterialWhere_Customer.xml' as CustomSchema, 'spx_Style_Custom_Where' as CustomStoredProc,
	@MaterialID as MaterialID, c.DesignSketchID,
	COALESCE(sc.Custom, c.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, c.SizeRange) AS SizeRange,
	c.Description,c.MaterialName,
	c.CustomField2,c.CustomField4, ssy.SeasonYearID
FROM pStyleBOM a 
	INNER JOIN pWorkFlowItem b ON a.WorkflowItemId = b.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ssy ON b.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleHeader c ON c.StyleID = a.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = c.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = c.SizeRangeId
	WHERE a.MaterialID = @MaterialID and MChange =  @MaterialVersion
	)a



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09786', GetDate())
GO
