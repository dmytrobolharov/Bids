IF OBJECT_ID(N'[dbo].[spx_StyleWorkflowActualStart_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflowActualStart_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowActualStart_UPDATE] 
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER = NULL,
	@ActualStart DATE
AS
BEGIN
  UPDATE dbo.pStyleWorkflow SET ActualStart = @ActualStart
  WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID AND 
        (StyleSeasonYearID = @StyleSeasonYearID OR StyleSeasonYearID IS NULL)
END 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09294', GetDate())
GO

