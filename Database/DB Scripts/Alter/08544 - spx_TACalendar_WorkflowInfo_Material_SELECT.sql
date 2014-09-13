/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Material_SELECT]    Script Date: 08/03/2014 16:59:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_Material_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Material_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Material_SELECT]    Script Date: 08/03/2014 16:59:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Material_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT mwp.MaterialID, mat.MaterialNo, mwp.MaterialWorkflowPageID, mwp.MaterialTemplatePageID, mwp.WorkAssignedTo, mwp.WorkStatus
    FROM vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT cal
    INNER JOIN pMaterialWorkflowPage mwp ON mwp.MaterialWorkflowPageID = cal.MaterialWorkflowPageID
    INNER JOIN pMaterial mat ON mat.MaterialID = mwp.MaterialID
    WHERE TACalRefTaskId = @TACalReferenceTaskID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08544', GetDate())
GO