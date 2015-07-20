
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleBOMWorkflowSupplierSpecSubmit_UPDATE]    Script Date: 12/23/2011 00:03:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleBOMWorkflowSupplierSpecSubmit_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleBOMWorkflowSupplierSpecSubmit_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleBOMWorkflowSupplierSpecSubmit_UPDATE]    Script Date: 12/23/2011 00:03:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleBOMWorkflowSupplierSpecSubmit_UPDATE]
(
	@RecCarrier NVARCHAR(50),
	@RecTrackNo NVARCHAR(50),
	@VendorWeight NVARCHAR(50),
	@VendorName NVARCHAR(200),
	@VendorDate NVARCHAR(50),
	@VendorComment NVARCHAR(4000),
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@StyleID UNIQUEIDENTIFIER,
	--@StyleColorID UNIQUEIDENTIFIER,
	@ItemDim1Id UNIQUEIDENTIFIER = NULL,
	@ItemDim2Id UNIQUEIDENTIFIER = NULL,
	@ItemDim3Id UNIQUEIDENTIFIER = NULL,	
	@StyleSet INT,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@Submit INT,
	@ModifiedBy NVARCHAR(200),
	@ModifiedDate DATETIME
)
AS 
BEGIN

	IF (SELECT COUNT(*) FROM pSampleRequestSpecSizeBOM WITH (NOLOCK) 
			WHERE 
				StyleID = @StyleID AND StyleSet = @StyleSet 
				AND SampleRequestTradeID = @SampleRequestTradeID 
				AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)) = 0

	BEGIN	

		INSERT INTO dbo.pSampleRequestSpecSizeBOM
			(
				SampleRequestSpecSizeID, SampleRequestTradeID, 
				SampleRequestWorkflowID, SampleWorkflowID, 
				WorkflowID, ItemDim1Id, ItemDim2Id, ItemDim3Id, 
				StyleID, SizeRange, StyleSet, 
				Size0, Size1, Size2, Size3, 
				Size4, Size5, Size6, Size7, 
				Size8, Size9, Size10, Size11, 
				Col0, Col1, Col2, Col3, Col4, 
				Col5, Col6, Col7, Col8, Col9, 
				Col10, Col11, Sel0, Sel1, Sel2, 
				Sel3, Sel4, Sel5, Sel6, Sel7, 
				Sel8, Sel9, Sel10, Sel11
			)
		SELECT     
				NEWID(), @SampleRequestTradeID, 
				@SampleRequestWorkflowID, @SampleWorkflowID, 
				'{40000000-0000-0000-0000-000000000005}',@ItemDim1Id, @ItemDim2Id, @ItemDim3Id, 
				StyleID, SizeRange, @StyleSet, 
				Size0, Size1, Size2, Size3, 
				Size4, Size5, Size6, Size7, 
				Size8, Size9, Size10, Size11, 
				0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 
				0, 0, Sel0, Sel1, Sel2, 
				Sel3, Sel4, Sel5, Sel6, Sel7, 
				Sel8, Sel9, Sel10, Sel11
		FROM    
			dbo.pStyleSpecSize WITH (NOLOCK)
		WHERE   
			(StyleID = @StyleID)

	END

	BEGIN

		UPDATE dbo.pSampleRequestSubmitBOM
		SET 
			VendorWeight = @VendorWeight, 
			VendorDate = @VendorDate, 
			VendorName = @VendorName, 
			VendorComment = @VendorComment, 
			RecCarrier = @RecCarrier, 
			RecTrackNo = @RecTrackNo, 
			TUser = @ModifiedBy, 
			TDate = @ModifiedDate  
		WHERE 
			(SampleRequestWorkflowID = @SampleRequestWorkflowID) 
			AND (SampleWorkflowID = @SampleWorkflowID) 
			AND (StyleID = @StyleID) 
			AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = ItemDim2Id) AND (ItemDim3Id = ItemDim3Id) 
			AND (StyleSet = @StyleSet) 
			AND (SampleRequestTradeID = @SampleRequestTradeID) 
			AND (Submit = @Submit)

	END                      

	BEGIN

		UPDATE dbo.pSampleRequestWorkflowBOM
		SET  
			TUser = @ModifiedBy, 
			TDate = @ModifiedDate
		WHERE 
			(SampleRequestWorkflowID = @SampleRequestWorkflowID) 
			AND (SampleWorkflowID = @SampleWorkflowID) 
			AND (StyleID = @StyleID) 
			AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = ItemDim2Id) AND (ItemDim3Id = ItemDim3Id)  
			AND (StyleSet = @StyleSet) 
			AND (SampleRequestTradeID = @SampleRequestTradeID) 

	END
END




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02502'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02502', GetDate())
END

GO

