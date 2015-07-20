IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_WorkflowStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_WorkflowStatus_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolder_WorkflowStatus_Logic_UPDATE]
	@ColorFolderWorkflowPageID UNIQUEIDENTIFIER,
	@UpdateSQL NVARCHAR(MAX)
AS

DECLARE @PrevWorkStatus INT,
		@WorkStatus INT,
		@NotStarted INT = 1,
		@Approved INT = 100,
		@Complete INT = 102;
		
SELECT @PrevWorkStatus = WorkStatus 
FROM pColorFolderWorkflowPage 
WHERE ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID

EXEC(@UpdateSQL)

SELECT @WorkStatus = WorkStatus 
FROM pColorFolderWorkflowPage 
WHERE ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID


IF @WorkStatus = @NotStarted AND @PrevWorkStatus <> @NotStarted
	UPDATE pColorFolderWorkflowPage 
	SET ActualStart = NULL, ActualEnd = NULL
	WHERE ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID		
ELSE IF @WorkStatus = @Approved AND @PrevWorkStatus <> @Approved
	UPDATE pColorFolderWorkflowPage 
	SET ActualEnd = GETDATE()
	WHERE ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID
ELSE IF @WorkStatus <> @Approved AND @WorkStatus <> @Complete AND @PrevWorkStatus = @Approved
	UPDATE pColorFolderWorkflowPage 
	SET ActualEnd = NULL
	WHERE ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID
ELSE IF @WorkStatus <> @Approved AND @WorkStatus <> @NotStarted AND @PrevWorkStatus = @NotStarted
	UPDATE pColorFolderWorkflowPage 
	SET ActualStart = GETDATE()
	WHERE ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID	
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08660', GetDate())
GO
