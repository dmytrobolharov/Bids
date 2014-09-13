
/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]    Script Date: 01/18/2013 12:38:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE]    Script Date: 01/18/2013 12:38:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflowTemplateItem_UPDATE](
@MaterialRequestWorkflowTempItemID uniqueidentifier,
@MaterialRequestWorkflowAssignedTo int,
@MaterialRequestPartnerTypeId uniqueidentifier,
@MaterialRequestWorkflowDays int,
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
	CUser = @CreatedBy, 
	CDate = @CreatedDate, 
	MUser = @CreatedBy, 
	MDate = @CreatedDate, 
	MaterialRequestWorkflowSort = @MaterialRequestWorkflowSort
WHERE (MaterialRequestWorkflowTempItemID = @MaterialRequestWorkflowTempItemID)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04812', GetDate())
GO
