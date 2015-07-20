IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderSKUHeader_Style_SYNC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderSKUHeader_Style_SYNC]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderSKUHeader_Style_SYNC]
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	UPDATE wfi SET 
		wfi.WorkFlowItemName = lfsh.LineFolderSKUHeaderName,
		wfi.WorkStatus = lfsh.WorkStatus
	FROM pLineFolderSKUHeader lfsh
	INNER JOIN pStyleSKUItem ssh ON lfsh.LineFolderSKUHeaderID = ssh.LineFolderSKUHeaderID
	INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
	WHERE lfsh.LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08123', GetDate())
GO
