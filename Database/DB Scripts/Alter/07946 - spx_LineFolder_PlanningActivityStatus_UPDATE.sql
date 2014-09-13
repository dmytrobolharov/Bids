IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_PlanningActivityStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_PlanningActivityStatus_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_PlanningActivityStatus_UPDATE]
(
	@PlanningActivityID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@Type NVARCHAR(2) /* 'R' - make as read, 'N' - make as new */
)
AS
BEGIN

	IF @Type = 'R'
	BEGIN
		IF NOT EXISTS (SELECT * FROM pPlanningActivityView WHERE PlanningActivityID = @PlanningActivityID AND TeamID = @TeamID)
		BEGIN
			INSERT INTO pPlanningActivityView (PlanningActivityID, TeamID)
			VALUES (@PlanningActivityID, @TeamID)
		END
	END
	ELSE IF @Type = 'N'
	BEGIN
		DELETE FROM pPlanningActivityView WHERE PlanningActivityID = @PlanningActivityID AND TeamID = @TeamID
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07946', GetDate())
GO
