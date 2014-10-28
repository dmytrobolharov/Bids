/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_COPY]    Script Date: 09/18/2014 12:47:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_COPY]
GO


/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_COPY]    Script Date: 09/18/2014 12:47:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_COPY](
	@TACalTemplateOLDID uniqueidentifier,
	@TACalTemplateNEWID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime
)

AS 

CREATE TABLE dbo.#tempTA
	(
	TACalTemplateTaskNEWID UNIQUEIDENTIFIER NOT NULL default newid()
	,TACalTemplateTaskOLDID UNIQUEIDENTIFIER
	)  ON [PRIMARY]
	
	INSERT INTO #tempTA (TACalTemplateTaskOLDID) 
	SELECT TACalTemplateTaskId from pTACalTemplateTask where TACalTemplateId=@TACalTemplateOLDID
	
	INSERT INTO pTACalTemplateTask (TACalTemplateTaskId, TACalTemplateId, TaskAssignedToId, TaskDepId, TaskDepTypeId, TaskDuration, TaskId, TaskName, TaskPlanEnd, TaskPlanStart, TaskProgress, TaskTypeId, TaskWorkflowId, endIsMilestone, level, startIsMilestone, Active, CDate, CUser, MDate, MUser) 
	SELECT TACalTemplateTaskNEWID, @TACalTemplateNEWID, TaskAssignedToId, TaskDepId, TaskDepTypeId, TaskDuration, TaskId, TaskName, TaskPlanEnd, TaskPlanStart, 0, TaskTypeId, TaskWorkflowId, endIsMilestone, level, startIsMilestone, Active, @CDate, @CUser, @CDate, @CUser from pTACalTemplateTask 
	INNER JOIN #tempTA ON #tempTA.TACalTemplateTaskOLDID =  pTACalTemplateTask.TACalTemplateTaskId 
	
	
	INSERT INTO pTACalTemplateTaskDep(CDate, CUser, MDate, MUser, TACalTemplateTaskChildId, TACalTemplateTaskDep, TACalTemplateTaskParentId, TATaskDepTypeId)
	select @Cdate, @CUser, @Cdate, @CUser,ta2.TACalTemplateTaskNEWID, NEWID(),  ta1.TACalTemplateTaskNEWID, TATaskDepTypeId   from pTACalTemplateTaskDep 
	INNER JOIN #tempTA ta1 ON ta1.TACalTemplateTaskOLDID = pTACalTemplateTaskDep.TACalTemplateTaskParentId
	INNER JOIN #tempTA ta2 ON ta2.TACalTemplateTaskOLDID = pTACalTemplateTaskDep.TACalTemplateTaskChildId
	
	drop table dbo.#tempTA
	


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09117', GetDate())
GO