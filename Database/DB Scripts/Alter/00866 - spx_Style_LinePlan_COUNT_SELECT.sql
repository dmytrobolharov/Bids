IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_LinePlan_COUNT_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Style_LinePlan_COUNT_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Style_LinePlan_COUNT_SELECT] (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS


IF EXISTS ( 
	SELECT *
	from pStyleSeasonYear a 
	INNER JOIN pLinePlanItem  b ON a.LinePlanItemID =  b.LinePlanItemID 
	WHERE a.StyleID  = @StyleID  
	AND a.SeasonYearID = @SeasonYearID
) 
	SELECT 1  AS Res
ELSE	
	SELECT 0 AS Res


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '866', GetDate())

GO
