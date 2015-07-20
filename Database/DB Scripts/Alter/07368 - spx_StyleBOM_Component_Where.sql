IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Component_Where]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Component_Where]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_Component_Where](
@MaterialID uniqueidentifier,
@MaterialVersion int,
@TeamID UNIQUEIDENTIFIER ,
@FieldSeason nvarchar (100), 
@FieldYear nvarchar (100)

)

AS 

SELECT DISTINCT ssy.StyleSeasonYearID , a.StyleID ,c.StyleNo ,c.DesignSketchVersion, 
	c.DesignSketchID,c.SizeClass,c.SizeRange,c.Description,c.MaterialName,
	c.CustomField2,c.CustomField4, ssy.SeasonYearID
FROM pStyleBOM a 
	INNER JOIN pWorkFlowItem b ON a.WorkflowItemId = b.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ssy ON b.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleHeader c ON c.StyleID = a.StyleID
	WHERE a.MaterialID = @MaterialID and MChange =  @MaterialVersion

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07368', GetDate())
GO
