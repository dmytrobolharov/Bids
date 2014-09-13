IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_TACalendar_COPY_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_TACalendar_COPY_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_TACalendar_COPY_INSERT]
	@OldTACalTemplateID UNIQUEIDENTIFIER,
	@NewTACalTemplateID UNIQUEIDENTIFIER,
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS

-- copy calendar
INSERT INTO pTACalTemplate(
	TACalTemplateId, TACalTemplateName, TACalTemplateDescription, SeasonYearId, 
	TACalTemplatePlanStart, TACalTemplatePlanEnd,
	Active, CUser, CDate, MUser, MDate)
SELECT @NewTACalTemplateID, TACalTemplateName, TACalTemplateDescription, SeasonYearId, 
	TACalTemplatePlanStart, TACalTemplatePlanEnd,
	Active, @CUser, @CDate, @CUser, @CDate
FROM pTACalTemplate WHERE TACalTemplateId = @OldTACalTemplateID

-- copy calendar divisions
INSERT INTO pTACalTemplateDivision(TACalTemplateID, DivisionID)
SELECT @NewTACalTemplateID, DivisionID
FROM pTACalTemplateDivision WHERE TACalTemplateId = @OldTACalTemplateID

exec spx_TACalTemplateTask_COPY
	@TACalTemplateOLDID = @OldTACalTemplateID,
	@TACalTemplateNEWID = @NewTACalTemplateID,
	@CUser = @CUser,
	@CDate = @CDate
	
exec spx_TACalTemplateTask_Root_UPDATE
	@templateid = @NewTACalTemplateID
	
-- associate it with planning
exec spx_Planning_TACalendar_INSERT
	@TACalTemplateID = @NewTACalTemplateID,
	@PlanningID = @PlanningID,
	@SeasonYearID = @SeasonYearID,
	@CUser = @CUser,
	@CDate = @CDate
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08772', GetDate())
GO
