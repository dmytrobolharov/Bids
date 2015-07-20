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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSize_SELECT]    Script Date: 12/18/2011 18:35:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecSize_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecSize_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSize_SELECT]    Script Date: 12/18/2011 18:35:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecSize_SELECT]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet nvarchar(5))
AS 

--DELETE FROM dbo.pSampleRequestSpecSize WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet)

Declare @SampleSizePosition int
Declare @Sample int

BEGIN
	SELECT  @SampleSizePosition = (CASE 
        WHEN Sel0 = 1 THEN 0
        WHEN Sel1 = 1 THEN 1 
        WHEN Sel2 = 1 THEN 2 
        WHEN Sel3 = 1 THEN 3 
        WHEN Sel4 = 1 THEN 4 
        WHEN Sel5 = 1 THEN 5 
        WHEN Sel6 = 1 THEN 6 
        WHEN Sel7 = 1 THEN 7 
        WHEN Sel8 = 1 THEN 8 
        WHEN Sel9 = 1 THEN 9 
        WHEN Sel10 = 1 THEN 10 
        WHEN Sel11 = 1 THEN 11 
        WHEN Sel12 = 1 THEN 12 
        WHEN Sel13 = 1 THEN 13 
        WHEN Sel14 = 1 THEN 14 
        WHEN Sel15 = 1 THEN 15 
        WHEN Sel16 = 1 THEN 16 
        WHEN Sel17 = 1 THEN 17 
        WHEN Sel18 = 1 THEN 18 
        WHEN Sel19 = 1 THEN 19 
        END) FROM dbo.pSampleRequestSpecSizeBOM WITH (NOLOCK)
	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet) 
END

	IF @SampleSizePosition IS NULL
	
	BEGIN
	
	DELETE FROM dbo.pSampleRequestSpecSizeBOM WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet)
	
	DECLARE @SampleWorkflowID varchar(10),
	@ItemDim1Id UNIQUEIDENTIFIER = null,
	@ItemDim2Id UNIQUEIDENTIFIER = null,
	@ItemDim3Id UNIQUEIDENTIFIER = null
	
	SELECT @SampleWorkflowID = SampleWorkflowID, @ItemDim1Id = ItemDim1Id,@ItemDim2Id = ItemDim2Id,@ItemDim3Id = ItemDim3Id
	FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
	
	
	INSERT INTO pSampleRequestSpecSizeBOM (StyleID, SizeRange, StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19, 
	Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
	MUser, MDate, SampleRequestSpecSizeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, ItemDim1Id,ItemDim2Id,ItemDim3Id, SampleRequestTradeID)
	SELECT StyleID, SizeRange, @StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19, 
	Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
	'SYSTEM', GETDATE(), NEWID(), @SampleRequestWorkflowID, @SampleWorkflowID, '{40000000-0000-0000-0000-000000000005}',  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id,@SampleRequestTradeID
	FROM dbo.pStyleSpecSize WITH (NOLOCK)
	WHERE (StyleID = @StyleID)

	SELECT StyleID, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
		Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
	FROM  dbo.pSampleRequestSpecSize WITH (NOLOCK)
	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND 
		(SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
		(StyleID = @StyleID) AND (StyleSet = @StyleSet)

	END
	
ELSE	

	BEGIN
		SELECT StyleID, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
			Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
		FROM  dbo.pSampleRequestSpecSizeBOM WITH (NOLOCK)
		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND 
			(SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
			(StyleID = @StyleID) AND (StyleSet = @StyleSet)
	END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02407'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02407', GetDate())

END

GO