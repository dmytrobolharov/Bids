IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendar_AssignedTo_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendar_AssignedTo_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendar_AssignedTo_UPDATE] (
	@TaskAssignedToId int,
	@StyleWorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@SeasonYearID uniqueidentifier
	)
AS
DECLARE @StyleSeasonYearID uniqueidentifier
			
BEGIN
	IF @StyleWorkflowID = 'ffffffff-eeee-1111-2323-333333333333'
		BEGIN
			SET @StyleSeasonYearID=(SELECT TOP 1 StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID =@StyleId AND SeasonYearID = @SeasonYearID)
			UPDATE pStyleTechPackStatus SET WorkAssignedTo = @TaskAssignedToId WHERE StyleID = @StyleID and StyleSeasonYearID = @StyleSeasonYearID
		END
	ELSE
		BEGIN
			UPDATE pStyleWorkflow SET WorkAssignedTo = @TaskAssignedToId WHERE StyleWorkflowID = @StyleWorkflowID
		END	
END

GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08591', GetDate())
GO


