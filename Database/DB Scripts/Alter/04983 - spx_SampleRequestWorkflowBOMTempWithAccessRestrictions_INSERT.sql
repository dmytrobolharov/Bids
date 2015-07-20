IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]
(@SampleWorkflowTempID uniqueidentifier,
@SampleScheduleType nvarchar(50),
@SampleRequestGroupID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@StyleSet2 nvarchar(50) = null,
@StyleSet3 nvarchar(50) = null,
@StyleSet4 nvarchar(50) = null,
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StartDate DateTime,
@EndDate DateTime,
@CreatedBy nvarchar(200),
@CreatedDate DateTime, 
@TeamID uniqueidentifier 
)
AS 

		UPDATE pSampleRequestSetItemTemp
		SET  SampleWorkflowTempID = @SampleWorkflowTempID, 
		SampleScheduleType = @SampleScheduleType, 
		StartDate = @StartDate,
		EndDate = @EndDate, 
		MUser = @CreatedBy, 
		MDate = @CreatedDate 
		WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestGroupID = @SampleRequestGroupID

		DELETE FROM pSampleRequestWorkflowBOMTemp WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestGroupID = @SampleRequestGroupID	

		INSERT INTO dbo.pSampleRequestWorkflowBOMTemp
		(SampleWorkflowTempItemID, SampleRequestGroupID, SampleWorkflowID, AssignedTo, Submit, 
		Status, SubmitDays, ResubmitDays, StyleID, StyleSet, ItemDim1Id,ItemDim2Id,ItemDim3Id, CUser, MUser, CDate, MDate, SampleWorkflowFinalDate , StartDate, SampleWorkflowPartnerTypeID )
		SELECT SampleWorkflowTempItemID, @SampleRequestGroupID, SampleWorkflowID, SampleWorkflowAssignedTo, 1, 
		1, SampleWorkflowDays, SampleWorkflowRDays, @StyleID AS StyleID, @StyleSet AS StyleSet, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', 
		@CreatedBy AS CUser, @CreatedBy AS MUser, @CreatedDate AS Cdate, @CreatedDate AS MDate, SampleWorkflowFinalDate ,
		@StartDate AS StartDate, SampleWorkflowPartnerTypeID
		FROM dbo.pSampleWorkflowItemTemplate
		WHERE (SampleWorkflowTempID = @SampleWorkflowTempID)
		ORDER BY SampleWorkflowSort	


--IF(@StyleSet2 is not null )
--BEGIN
--UPDATE pSampleRequestSetItemTemp
--		SET  SampleWorkflowTempID = @SampleWorkflowTempID, 
--		SampleScheduleType = @SampleScheduleType, 
--		StartDate = @StartDate,
--		EndDate = @EndDate, 
--		MUser = @CreatedBy, 
--		MDate = @CreatedDate 
--		WHERE StyleID = @StyleID AND StyleSet = @StyleSet2 AND SampleRequestGroupID = @SampleRequestGroupID

--		DELETE FROM pSampleRequestWorkflowBOMTemp WHERE StyleID = @StyleID AND StyleSet = @StyleSet2 AND SampleRequestGroupID = @SampleRequestGroupID	

--		INSERT INTO dbo.pSampleRequestWorkflowBOMTemp
--		(SampleWorkflowTempItemID, SampleRequestGroupID, SampleWorkflowID, AssignedTo, Submit, 
--		Status, SubmitDays, ResubmitDays, StyleID, StyleSet, ItemDim1Id,ItemDim2Id,ItemDim3Id, CUser, MUser, CDate, MDate, SampleWorkflowFinalDate , StartDate  )
--		SELECT SampleWorkflowTempItemID, @SampleRequestGroupID, SampleWorkflowID, SampleWorkflowAssignedTo, 1, 
--		1, SampleWorkflowDays, SampleWorkflowRDays, @StyleID AS StyleID, @StyleSet2 AS StyleSet, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', 
--		@CreatedBy AS CUser, @CreatedBy AS MUser, @CreatedDate AS Cdate, @CreatedDate AS MDate, SampleWorkflowFinalDate ,
--		@StartDate AS StartDate 
--		FROM dbo.pSampleWorkflowItemTemplate
--		WHERE (SampleWorkflowTempID = @SampleWorkflowTempID)
--		ORDER BY SampleWorkflowSort	
--END	

--IF(@StyleSet3 is not null )
--BEGIN
--UPDATE pSampleRequestSetItemTemp
--		SET  SampleWorkflowTempID = @SampleWorkflowTempID, 
--		SampleScheduleType = @SampleScheduleType, 
--		StartDate = @StartDate,
--		EndDate = @EndDate, 
--		MUser = @CreatedBy, 
--		MDate = @CreatedDate 
--		WHERE StyleID = @StyleID AND StyleSet = @StyleSet3 AND SampleRequestGroupID = @SampleRequestGroupID

--		DELETE FROM pSampleRequestWorkflowBOMTemp WHERE StyleID = @StyleID AND StyleSet = @StyleSet3 AND SampleRequestGroupID = @SampleRequestGroupID	

--		INSERT INTO dbo.pSampleRequestWorkflowBOMTemp
--		(SampleWorkflowTempItemID, SampleRequestGroupID, SampleWorkflowID, AssignedTo, Submit, 
--		Status, SubmitDays, ResubmitDays, StyleID, StyleSet, ItemDim1Id,ItemDim2Id,ItemDim3Id, CUser, MUser, CDate, MDate, SampleWorkflowFinalDate , StartDate  )
--		SELECT SampleWorkflowTempItemID, @SampleRequestGroupID, SampleWorkflowID, SampleWorkflowAssignedTo, 1, 
--		1, SampleWorkflowDays, SampleWorkflowRDays, @StyleID AS StyleID, @StyleSet3 AS StyleSet, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', 
--		@CreatedBy AS CUser, @CreatedBy AS MUser, @CreatedDate AS Cdate, @CreatedDate AS MDate, SampleWorkflowFinalDate ,
--		@StartDate AS StartDate 
--		FROM dbo.pSampleWorkflowItemTemplate
--		WHERE (SampleWorkflowTempID = @SampleWorkflowTempID)
--		ORDER BY SampleWorkflowSort	
--END	



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04983', GetDate())
GO
