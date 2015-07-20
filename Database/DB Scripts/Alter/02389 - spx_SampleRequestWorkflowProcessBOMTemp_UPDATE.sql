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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_UPDATE]    Script Date: 12/18/2011 18:25:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowProcessBOMTemp_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_UPDATE]    Script Date: 12/18/2011 18:25:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_UPDATE]
(
@SampleRequestGroupID uniqueidentifier,
@SampleRequestWorkflowID nvarchar(50), 
@SampleWorkflowTempItemID nvarchar(50), 
@StyleRequestWorkflowSetItemID nvarchar(50), 
@SampleWorkflowID nvarchar(10),
@StyleID nvarchar(50),
@ItemDim1Id  nvarchar(50) = null,
@ItemDim2Id  nvarchar(50) = null,
@ItemDim3Id  nvarchar(50) = null,
@StyleSet nvarchar(10),
@Submit int,
@AssignedTo nvarchar(50),
@SubmitDays nvarchar(50),
@DueDate nvarchar(50),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(100)
)
AS 


IF (SELECT COUNT(*) FROM pSampleRequestWorkflowBOMTemp WITH (NOLOCK) WHERE SampleWorkflowID = @SampleWorkflowID AND ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id AND StyleID = @StyleID AND StyleSet = @StyleSet) = 0 
	BEGIN
		 INSERT INTO pSampleRequestWorkflowBOMTemp
         (SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleWorkflowID, SampleWorkflowTempItemID, AssignedTo, DueDate, SubmitDays, ItemDim1Id,ItemDim2Id,ItemDim3Id, SampleRequestGroupID, Submit, Status, StyleID, StyleSet, CUser, CDate, MUser, MDate)
		VALUES (@SampleRequestWorkflowID, @StyleRequestWorkflowSetItemID, @SampleWorkflowID, @SampleWorkflowTempItemID, @AssignedTo, @DueDate, @SubmitDays, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @SampleRequestGroupID, 1, 1, @StyleID, @StyleSet,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	END


IF (SELECT COUNT(*) FROM pSampleRequestSubmitBOMTemp WITH (NOLOCK) WHERE SampleWorkflowID = @SampleWorkflowID AND ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id  AND StyleID = @StyleID AND StyleSet = @StyleSet) = 0 
	BEGIN
		 INSERT INTO dbo.pSampleRequestSubmitBOMTemp
         (SampleRequestWorkflowID, SampleWorkflowID, AssignedTo, DueDate, SubmitDays,  ItemDim1Id,ItemDim2Id,ItemDim3Id,  SampleRequestGroupID, Submit, Status, StyleID, StyleSet, CUser, CDate, MUser, MDate)
		VALUES (@SampleRequestWorkflowID, @SampleWorkflowID, @AssignedTo, @DueDate, @SubmitDays,  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @SampleRequestGroupID, 1, 1, @StyleID, @StyleSet,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	END

IF (SELECT COUNT(*) FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE StyleRequestWorkflowSetItemID = @StyleRequestWorkflowSetItemID) = 0 
	BEGIN
		INSERT INTO pSampleRequestSetItemTemp
			(StyleRequestWorkflowSetItemID, SampleWorkflowTempID, SampleScheduleType, StartDate, EndDate, StyleID, StyleColorID, StyleSet, CUser, CDate, 
			MUser, MDate, Active)
		SELECT StyleRequestWorkflowSetItemID, SampleWorkflowTempID, SampleScheduleType, StartDate, EndDate, StyleID, StyleColorID, StyleSet, CUser, CDate, 
			MUser, MDate, Active
		FROM pSampleRequestSetItem WITH (NOLOCK) WHERE StyleRequestWorkflowSetItemID = @StyleRequestWorkflowSetItemID	
	END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02389'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02389', GetDate())

END

GO