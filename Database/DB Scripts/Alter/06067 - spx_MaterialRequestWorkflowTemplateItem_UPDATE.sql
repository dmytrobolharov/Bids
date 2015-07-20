/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]    Script Date: 07/19/2013 11:17:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]    Script Date: 07/19/2013 11:17:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE](
@MaterialRequestWorkflowTempItemID uniqueidentifier,
@MaterialRequestWorkflowAssignedTo int,
@MaterialRequestPartnerTypeId uniqueidentifier,
@MaterialRequestWorkflowDays int,
@MaterialRequestWorkflowResubmitDays int,
@MaterialRequestWorkflowAlerts int,
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@MaterialRequestWorkflowSort varchar(5)
)
AS 
UPDATE pMaterialRequestWorkflowTemplateItem SET              
	MaterialRequestWorkflowAssignedTo = @MaterialRequestWorkflowAssignedTo, 
	MaterialRequestPartnerTypeId=@MaterialRequestPartnerTypeId,
	MaterialRequestWorkflowDays = @MaterialRequestWorkflowDays, 
	MaterialRequestWorkflowAlerts = @MaterialRequestWorkflowAlerts, 
	MaterialRequestWorkflowRDays = @MaterialRequestWorkflowResubmitDays,
	CUser = @CreatedBy, 
	CDate = @CreatedDate, 
	MUser = @CreatedBy, 
	MDate = @CreatedDate, 
	MaterialRequestWorkflowSort = @MaterialRequestWorkflowSort
WHERE (MaterialRequestWorkflowTempItemID = @MaterialRequestWorkflowTempItemID)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06067', GetDate())
GO
