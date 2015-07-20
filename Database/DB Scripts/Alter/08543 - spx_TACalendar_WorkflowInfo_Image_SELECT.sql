/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Image_SELECT]    Script Date: 08/03/2014 16:29:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Image_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Image_SELECT]    Script Date: 08/03/2014 16:29:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Image_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT iwp.ImageID, i.ImageNo, iwp.ImageWorkflowPageID, iwp.ImageWorkflowTemplateItemID, iwp.WorkAssignedTo, iwp.WorkStatus
    FROM vwx_TACalTemplateTask_ReferenceFromImage_SELECT cal
    INNER JOIN pImageWorkflowPage iwp ON iwp.ImageWorkflowPageID = cal.ImageWorkflowPageID
    INNER JOIN pImage i ON i.ImageID = iwp.ImageID
    WHERE TACalRefTaskId = @TACalReferenceTaskID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08543', GetDate())
GO