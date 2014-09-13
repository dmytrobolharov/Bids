IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_SeasonYear_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflow_SeasonYear_SELECT](
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID NVARCHAR(50)
)
AS 

IF (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID) = 1
BEGIN
	SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
END
ELSE
BEGIN
	SELECT '' AS StyleSeasonYearID
END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08479', GetDate())
GO

