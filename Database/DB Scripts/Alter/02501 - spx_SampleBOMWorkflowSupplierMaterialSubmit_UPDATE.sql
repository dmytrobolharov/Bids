
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

/****** Object:  StoredProcedure [dbo].[spx_SampleBOMWorkflowSupplierMaterialSubmit_UPDATE]    Script Date: 12/23/2011 00:02:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleBOMWorkflowSupplierMaterialSubmit_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleBOMWorkflowSupplierMaterialSubmit_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleBOMWorkflowSupplierMaterialSubmit_UPDATE]    Script Date: 12/23/2011 00:02:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleBOMWorkflowSupplierMaterialSubmit_UPDATE]
(
	@VendorName NVARCHAR(200),
	@VendorDate NVARCHAR(50),
	@VendorComment NVARCHAR(4000),
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@StyleID UNIQUEIDENTIFIER,
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
	BEGIN
		UPDATE dbo.pSampleRequestSubmitBOM
		SET 
			VendorWeight = NULL, 
			VendorDate = @VendorDate, 
			VendorName = @VendorName,  -- VendorComment = @VendorComment, 
			RecCarrier = NULL, 
			RecTrackNo = NULL, 
			TUser = @ModifiedBy, 
			TDate = @ModifiedDate	
		WHERE 
			(SampleRequestWorkflowID = @SampleRequestWorkflowID) 
			AND (SampleWorkflowID = @SampleWorkflowID) 
			AND (StyleID = @StyleID) 
			AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)
			AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
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
			AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) 
			AND (StyleSet = @StyleSet) 
			AND (SampleRequestTradeID = @SampleRequestTradeID) 
	END
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02501'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02501', GetDate())
END

GO

