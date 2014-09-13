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

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitSpec_INSERT]    Script Date: 12/18/2011 18:40:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmitSpec_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitSpec_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitSpec_INSERT]    Script Date: 12/18/2011 18:40:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitSpec_INSERT]
(
	@SampleRequestSubmitId uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID nvarchar(5),
	@SampleRequestTradeID uniqueidentifier,
	@StyleID uniqueidentifier,
	@ItemDim1Id UNIQUEIDENTIFIER = null,
	@ItemDim2Id UNIQUEIDENTIFIER = null,
	@ItemDim3Id UNIQUEIDENTIFIER = null,
	@StyleSet int,
	@CreatedDate nvarchar(50),
	@CreatedBy nvarchar(50),
	@Submit int,
	@NewSubmit nvarchar(50)
)
AS 

	DECLARE @ResubmitDays int
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID

BEGIN
	INSERT INTO pSampleRequestSpecItemBOM
		(Submit, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, TradePartnerVendorID, SpecID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, POM,
		PointMeasur, TOL, TOLN, Ask, Spec, [Var], Rev, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Grade0, 
		Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, 
		Size8, Size9, Size10, Size11, CDate, CUser, MDate, MUser, Change, Final, SpecMasterID, POMTempItemID, POMLibraryID, POMTempID, 
		ModelSpecID, ModelID, Critical, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Size12, Size13, Size14, Size15, Size16, 
		Size17, Size18, Size19, Sort)
	SELECT     @NewSubmit AS Expr1, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, TradePartnerVendorID, SpecID, StyleID, 
		ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, POM, PointMeasur, TOL, TOLN, Rev, 0 AS Expr2, 0 AS Expr3, 0 AS Expr4, 0 AS Expr5, 0 AS Expr6, 0 AS Expr7, 0 AS Expr8, 0 AS Expr9, 
		0 AS Expr10, 0 AS Expr11, 0 AS Expr12, 0 AS Expr13, 0 AS Expr14, 0 AS Expr15, 0 AS Expr16, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, 
		Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
		@CreatedDate AS Expr17, @CreatedBy AS Expr18, @CreatedDate AS Expr19, @CreatedBy AS Expr20, Change, 0 AS Final, SpecMasterID, 
		POMTempItemID, POMLibraryID, POMTempID, ModelSpecID, ModelID, Critical, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, 
		Grade19, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Sort
	FROM   pSampleRequestSpecItemBOM WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
	(StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (Submit = @Submit)
END  

BEGIN
	INSERT INTO pSampleRequestSubmitBOM
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
END                      
                      
BEGIN


	UPDATE pSampleRequestWorkflowBOM
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02415'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02415', GetDate())

END

GO