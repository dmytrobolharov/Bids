-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]    Script Date: 12/18/2011 18:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]    Script Date: 12/18/2011 18:00:09 ******/
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

		UPDATE pSampleRequestSetBOMItemTemp
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
		Status, SubmitDays, ResubmitDays, StyleID, StyleSet, ItemDim1Id,ItemDim2Id,ItemDim3Id, CUser, MUser, CDate, MDate, SampleWorkflowFinalDate , StartDate  )
		SELECT SampleWorkflowTempItemID, @SampleRequestGroupID, SampleWorkflowID, SampleWorkflowAssignedTo, 1, 
		1, SampleWorkflowDays, SampleWorkflowRDays, @StyleID AS StyleID, @StyleSet AS StyleSet, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', 
		@CreatedBy AS CUser, @CreatedBy AS MUser, @CreatedDate AS Cdate, @CreatedDate AS MDate, SampleWorkflowFinalDate ,
		@StartDate AS StartDate 
		FROM dbo.pSampleWorkflowItemTemplate
		WHERE (SampleWorkflowTempID = @SampleWorkflowTempID)
		ORDER BY SampleWorkflowSort	


--IF(@StyleSet2 is not null )
--BEGIN
--UPDATE pSampleRequestSetBOMItemTemp
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
--UPDATE pSampleRequestSetBOMItemTemp
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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02364'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02364', GetDate())

END

GO