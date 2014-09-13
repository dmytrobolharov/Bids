IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSKUHeader_Style_SYNC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSKUHeader_Style_SYNC]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSKUHeader_Style_SYNC]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	UPDATE wfi SET 
		wfi.WorkFlowItemName = psh.PlanningSKUHeaderName,
		wfi.WorkStatus = psh.WorkStatus
	FROM pPlanningSKUHeader psh
	INNER JOIN pStyleSKUItem ssh ON psh.PlanningSKUHeaderID = ssh.PlanningSKUHeaderID
	INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
	WHERE psh.PlanningSKUHeaderID = @PlanningSKUHeaderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07978', GetDate())
GO
