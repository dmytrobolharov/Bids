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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMQASize_SELECT]    Script Date: 12/18/2011 18:38:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMQASize_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMQASize_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMQASize_SELECT]    Script Date: 12/18/2011 18:38:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMQASize_SELECT]
(
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet nvarchar(5)
)
AS 

IF (SELECT COUNT(*) FROM pSampleRequestQASizeBOM WITH (NOLOCK)
	WHERE (SampleRequestTradeID = @SampleRequestTradeID) 
		AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
		AND (StyleID = @StyleID) 
		AND (StyleSet = @StyleSet)) = 0

BEGIN
	

	DECLARE @SampleWorkflowID varchar(10)
	DECLARE @ItemDim1Id UNIQUEIDENTIFIER = null
	DECLARE @ItemDim2Id UNIQUEIDENTIFIER = null
	DECLARE @ItemDim3Id UNIQUEIDENTIFIER = null
	
	SELECT @SampleWorkflowID = SampleWorkflowID, @ItemDim1Id = ItemDim1Id,@ItemDim2Id = ItemDim2Id,@ItemDim3Id = ItemDim3Id
	FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
	
	INSERT INTO pSampleRequestQASizeBOM (StyleID, SizeRange, StyleSet, 
		Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
		Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19, 
		Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
		MUser, MDate, SampleRequestQASizeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, ItemDim1Id,ItemDim2Id,ItemDim3Id, SampleRequestTradeID)
		SELECT StyleID, SizeRange, @StyleSet, 
		Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		'SYSTEM', GETDATE(), NEWID(), @SampleRequestWorkflowID, @SampleWorkflowID, '{40000000-0000-0000-0000-000000000005}',  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @SampleRequestTradeID
	FROM pStyleSpecSize WITH (NOLOCK)
	WHERE (StyleID = @StyleID)

	SELECT StyleID, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
		Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
	FROM  pSampleRequestQASizeBOM WITH (NOLOCK)
	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND 
		(SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
		(StyleID = @StyleID) AND (StyleSet = @StyleSet)

	END
	
ELSE	

	BEGIN
		SELECT StyleID, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
			Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
		FROM  pSampleRequestQASizeBOM WITH (NOLOCK)
		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND 
			(SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
			(StyleID = @StyleID) AND (StyleSet = @StyleSet)
	END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02412'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02412', GetDate())

END

GO