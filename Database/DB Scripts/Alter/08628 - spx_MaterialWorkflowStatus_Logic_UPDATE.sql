IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowStatus_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowStatus_Logic_UPDATE]
	@MaterialWorkflowPageID UNIQUEIDENTIFIER = NULL,
	@MaterialID UNIQUEIDENTIFIER = NULL,
	@MaterialTemplatePageID UNIQUEIDENTIFIER = NULL,
	@PageChange INT = 0,
	@PrevWorkStatus INT = NULL, /* if null - will select the current one */
	@WorkStatus INT
AS

DECLARE @NotStarted INT = 1,
		@Approved INT = 100,
		@Complete INT = 102;
		
IF @MaterialWorkflowPageID IS NULL
	SELECT @MaterialWorkflowPageID = MaterialWorkflowPageID
	FROM pMaterialWorkflowPage 
	WHERE MaterialID = @MaterialID AND MaterialTemplatePageID = @MaterialTemplatePageID
	
IF @PrevWorkStatus IS NULL
	SELECT @PrevWorkStatus = WorkStatus 
	FROM pMaterialWorkflowPage
	WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID

-- apply changes only if page is changeing from Not Started
IF @PageChange = 1 AND @PrevWorkStatus <> @NotStarted
	RETURN
	
UPDATE pMaterialWorkflowPage
SET WorkStatus = @WorkStatus
WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID 
	AND WorkStatus <> @WorkStatus
	
IF @WorkStatus = @NotStarted AND @PrevWorkStatus <> @NotStarted
	UPDATE pMaterialWorkflowPage 
	SET ActualStart = NULL, ActualEnd = NULL
	WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID
ELSE IF @PrevWorkStatus = @NotStarted AND @WorkStatus <> @Approved
	UPDATE pMaterialWorkflowPage 
	SET ActualStart = GETDATE()
	WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID
ELSE IF @WorkStatus = @Approved AND @PrevWorkStatus <> @Approved
	UPDATE pMaterialWorkflowPage 
	SET ActualEnd = GETDATE()
	WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID
ELSE IF @WorkStatus <> @Approved AND @WorkStatus <> @Complete AND @PrevWorkStatus = @Approved
	UPDATE pMaterialWorkflowPage 
	SET ActualEnd = NULL
	WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08628', GetDate())
GO
