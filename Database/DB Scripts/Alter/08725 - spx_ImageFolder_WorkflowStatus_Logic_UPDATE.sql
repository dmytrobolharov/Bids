IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageFolder_WorkflowStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageFolder_WorkflowStatus_Logic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_ImageFolder_WorkflowStatus_Logic_UPDATE] (
	@ImageWorkflowPageID UNIQUEIDENTIFIER,
	@UpdateSQL NVARCHAR(MAX)
)
AS
DECLARE @PrevWorkStatus INT,
		@WorkStatus INT,
		@NotStarted INT = 1,
		@Approved INT = 100,
		@Complete INT = 102;
		
SELECT @PrevWorkStatus = WorkStatus 
FROM pImageWorkflowPage 
WHERE ImageWorkflowPageID = @ImageWorkflowPageID

EXEC(@UpdateSQL)

SELECT @WorkStatus = WorkStatus 
FROM pImageWorkflowPage 
WHERE ImageWorkflowPageID = @ImageWorkflowPageID


IF @WorkStatus = @NotStarted AND @PrevWorkStatus <> @NotStarted
	UPDATE pImageWorkflowPage 
	SET ActualStart = NULL, ActualEnd = NULL
	WHERE ImageWorkflowPageID = @ImageWorkflowPageID		
ELSE IF @WorkStatus = @Approved AND @PrevWorkStatus <> @Approved
	UPDATE pImageWorkflowPage 
	SET ActualEnd = GETDATE()
	WHERE ImageWorkflowPageID = @ImageWorkflowPageID
ELSE IF @WorkStatus <> @Approved AND @WorkStatus <> @Complete AND @PrevWorkStatus = @Approved
	UPDATE pImageWorkflowPage 
	SET ActualEnd = NULL
	WHERE ImageWorkflowPageID = @ImageWorkflowPageID
ELSE IF @WorkStatus <> @Approved AND @WorkStatus <> @NotStarted AND @PrevWorkStatus = @NotStarted
	UPDATE pImageWorkflowPage 
	SET ActualStart = GETDATE()
	WHERE ImageWorkflowPageID = @ImageWorkflowPageID	
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08725', GetDate())
GO
