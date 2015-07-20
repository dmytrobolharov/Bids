IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowTACalendar_SEL]
GO

CREATE PROCEDURE [dbo].[spx_ImageWorkflowTACalendar_SEL] (
	@ImageID uniqueidentifier,
	@WorkflowTemplateID uniqueidentifier,
	@TACalReferenceId uniqueidentifier,
	@ShowOnlyTrackedPages int = 0
	)
AS
BEGIN
	declare @TACalReferenceIdString nvarchar(50)
	SET @TACalReferenceIdString = CAST(@TACalReferenceId as nvarchar(50));
	
	IF @TACalReferenceIdString  = '00000000-0000-0000-0000-000000000000' OR @TACalReferenceIdString = '' OR @TACalReferenceIdString IS NULL
		BEGIN			
			SELECT *,NULL AS TACalReferenceId, NULL AS TaskPlanStart, NULL AS TaskPlanEnd, NULL AS TaskRevisedlStart, 
					 NULL AS TaskRevisedEnd, NULL AS WorkflowId, NULL AS TaskAssignedToId, NULL AS TACalRefTaskId, '<img src="../System/Icons/' + ws.WorkflowStatusImage + '" alt="" />' AS StatusIcon 
			FROM pImageWorkflowPage iwp
			INNER JOIN pImageWorkflowTemplateEntry iwte ON iwp.ImageWorkflowTemplateEntryID = iwte.ImageWorkflowTemplateEntryID
			INNER JOIN pImageWorkflowTemplateItem iwti ON iwte.ImageWorkflowTemplateItemID = iwti.ImageWorkflowTemplateItemID
			INNER JOIN pWorkflowStatus ws on iwp.WorkStatus = ws.WorkflowStatusID
			WHERE iwp.ImageID = @ImageID AND iwte.ImageWorkflowTemplateID = @WorkflowTemplateID
		END
--ORDER
	ELSE
		BEGIN
		IF @ShowOnlyTrackedPages = 1
			BEGIN
			SELECT *, '<img src="../System/Icons/' + ws.WorkflowStatusImage + '" alt="" />' AS StatusIcon 
			FROM pImageWorkflowPage iwp
			INNER JOIN pImageWorkflowTemplateEntry iwte ON iwp.ImageWorkflowTemplateEntryID = iwte.ImageWorkflowTemplateEntryID
			INNER JOIN pImageWorkflowTemplateItem iwti ON iwte.ImageWorkflowTemplateItemID = iwti.ImageWorkflowTemplateItemID
			INNER JOIN pWorkflowStatus ws on iwp.WorkStatus = ws.WorkflowStatusID
				 LEFT JOIN pTACalReference r
				   INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
				   INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				   INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
				   ON r.ReferenceId = @ImageID AND iwp.ImageWorkflowTemplateItemID = tw.WorkflowId
				   WHERE iwp.ImageID = @ImageID AND iwte.ImageWorkflowTemplateID = @WorkflowTemplateID
				   --AND rt.TACalReferenceId=@TACalReferenceId
--ORDER	 			
			END
		ELSE
			BEGIN	
			SELECT *, '<img src="../System/Icons/' + ws.WorkflowStatusImage + '" alt="" />' AS StatusIcon 
			FROM pImageWorkflowPage iwp
			INNER JOIN pImageWorkflowTemplateEntry iwte ON iwp.ImageWorkflowTemplateEntryID = iwte.ImageWorkflowTemplateEntryID
			INNER JOIN pImageWorkflowTemplateItem iwti ON iwte.ImageWorkflowTemplateItemID = iwti.ImageWorkflowTemplateItemID
			INNER JOIN pWorkflowStatus ws on iwp.WorkStatus = ws.WorkflowStatusID
				 LEFT JOIN pTACalReference r
				   INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
				   INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				   INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
				   ON r.ReferenceId = @ImageID AND iwp.ImageWorkflowTemplateItemID = tw.WorkflowId
				   WHERE iwp.ImageID = @ImageID AND iwte.ImageWorkflowTemplateID = @WorkflowTemplateID
				   --AND rt.TACalReferenceId=@TACalReferenceId 				
			END	
		END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08716', GetDate())
GO

