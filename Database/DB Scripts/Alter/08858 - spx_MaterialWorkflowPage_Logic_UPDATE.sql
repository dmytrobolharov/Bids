/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]    Script Date: 08/14/2014 13:40:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflowPage_Logic_UPDATE]    Script Date: 08/14/2014 13:40:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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


-- Recalculating progress for all calendar tasks with current workflow
DECLARE @MaterialTemplatePageID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER

SELECT @MaterialTemplatePageID = MaterialTemplatePageID, @MaterialID = MaterialID 
FROM pMaterialWorkflowPage 
WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID

EXEC spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE @MaterialTemplatePageID, @MaterialID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08858', GetDate())
GO
