IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Milestone_Task_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Milestone_Task_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Milestone_Task_INSERT]
	@MilestoneID UNIQUEIDENTIFIER,
	@TaskID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN

	DECLARE @Sort INT = (SELECT MAX(CASE WHEN ISNUMERIC(Sort) = 1 THEN CAST(Sort as INT) ELSE 0 END) + 1 FROM pMilestoneItem)
	if @Sort IS NULL
		set @Sort = 1
	
	INSERT INTO pMilestoneItem(MilestoneID, TaskID, MilestoneItemName, MilestoneItemDescription, DependencyID, Sort, CUser, CDate, MUser, MDate)
	SELECT @MilestoneID, TaskID, TaskName, TaskDescription, '00000000-0000-0000-0000-000000000000', @Sort, @CUser, @CDate, @CUser, @CDate
	FROM cCalendarTask WHERE TaskID = @TaskID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07133', GetDate())
GO
