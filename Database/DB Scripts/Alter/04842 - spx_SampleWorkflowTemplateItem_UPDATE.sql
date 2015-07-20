IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowTemplateItem_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowTemplateItem_UPDATE]
(@SampleWorkflowAssignedTo int,
@SampleWorkflowDays int,
@SampleWorkflowRDays int,
@SampleWorkflowAlerts int,
@ModifiedBy nvarchar(50),
@ModifiedDate datetime,
@SampleWorkflowFinalDate datetime,
@SampleWorkflowTempItemID uniqueidentifier,
@SampleWorkflowPartnerTypeID uniqueidentifier)
AS 



UPDATE pSampleWorkflowItemTemplate
SET SampleWorkflowAssignedTo = @SampleWorkflowAssignedTo, SampleWorkflowDays = @SampleWorkflowDays, 
    SampleWorkflowRDays = @SampleWorkflowRDays, SampleWorkflowAlerts = @SampleWorkflowAlerts, MUser = @ModifiedBy, MDate = @ModifiedDate, 
	SampleWorkflowFinalDate = @SampleWorkflowFinalDate, 
	SampleWorkflowPartnerTypeID = @SampleWorkflowPartnerTypeID
WHERE (SampleWorkflowTempItemID = @SampleWorkflowTempItemID)


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04842', GetDate())
GO
