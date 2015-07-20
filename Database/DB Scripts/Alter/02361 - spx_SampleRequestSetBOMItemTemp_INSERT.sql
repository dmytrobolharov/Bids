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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSetBOMItemTemp_INSERT]    Script Date: 12/18/2011 17:56:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSetBOMItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSetBOMItemTemp_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSetBOMItemTemp_INSERT]    Script Date: 12/18/2011 17:56:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestSetBOMItemTemp_INSERT]
(
@SampleRequestGroupID uniqueidentifier,
@StyleID uniqueidentifier,
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StyleSet nvarchar(10),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(100)
)

AS

DELETE FROM  pSampleRequestSetBOMItemTemp WHERE StyleID = @StyleID  AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet 
--DELETE FROM pSampleRequestWorkflowTemp WHERE SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet 

IF (SELECT COUNT(*) FROM pSampleRequestSetBOMItemTemp WITH (NOLOCK) WHERE StyleID = @StyleID AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet)  = 0

	BEGIN
		 INSERT INTO pSampleRequestSetBOMItemTemp
        		 (SampleRequestGroupID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleID, StyleSet, CUser, CDate, MUser, MDate)
		VALUES (@SampleRequestGroupID, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @StyleID, @StyleSet,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	END	
	
ELSE

	BEGIN
	
		UPDATE pSampleRequestSetBOMItemTemp
		SET  ItemDim1Id=@ItemDim1Id,ItemDim2Id=@ItemDim2Id,ItemDim3Id=@ItemDim3Id
		, StyleID = @StyleID, StyleSet = @StyleSet,
		MUser = @CreatedBy, MDate = @CreatedDate 
		WHERE (SampleRequestGroupID = @SampleRequestGroupID)
	
	END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02361'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02361', GetDate())

END

GO

