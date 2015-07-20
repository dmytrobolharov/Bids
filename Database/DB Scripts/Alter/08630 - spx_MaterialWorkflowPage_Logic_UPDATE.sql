IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]
	@MaterialWorkflowPageID UNIQUEIDENTIFIER,
	@UpdateSQL NVARCHAR(MAX)
AS

DECLARE @PrevWorkStatus INT,
		@WorkStatus INT,
		@NotStarted INT = 1,
		@Approved INT = 100,
		@Complete INT = 102;
		
SELECT @PrevWorkStatus = WorkStatus 
FROM pMaterialWorkflowPage 
WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID

EXEC(@UpdateSQL)

SELECT @WorkStatus = WorkStatus 
FROM pMaterialWorkflowPage 
WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID


exec spx_MaterialWorkflowStatus_Logic_UPDATE
	@MaterialWorkflowPageID = @MaterialWorkflowPageID,
	@PrevWorkStatus = @PrevWorkStatus,
	@WorkStatus = @WorkStatus


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08630', GetDate())
GO
