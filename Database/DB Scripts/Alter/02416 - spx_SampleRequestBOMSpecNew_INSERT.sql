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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecNew_INSERT]    Script Date: 12/18/2011 18:40:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecNew_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecNew_INSERT]    Script Date: 12/18/2011 18:40:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecNew_INSERT]
(
@POM varchar(5),
@SpecID uniqueidentifier,
@StyleID uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleSet int,
@TeamID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@Submit int,
@CreatedDate datetime,
@CreatedBy nvarchar(225)
)
AS 

DECLARE @newSpecID uniqueidentifier
SET @newSpecID = newid()


INSERT INTO dbo.pSampleRequestSpecItemBOM
    (SpecID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, TradePartnerVendorID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, Submit, POM,
    PointMeasur, TOL, TOLN, Ask, Spec, [Var], Rev, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, 
    Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, 
    Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Size0, Size1, Size2, Size3, Size4, Size5, 
    Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Final, Change, CDate, CUser, MDate, 
    MUser)
VALUES     (@newSpecID, @StyleID, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @StyleSet, @TeamID, @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, 
    @Submit, @POM, @POM, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy)

                      
Declare @Sample INT

BEGIN
SELECT  @Sample = (CASE 
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
WHERE (StyleID = @StyleID) 
AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
AND (SampleWorkflowID = @SampleWorkflowID) 
AND (SampleRequestTradeID = @SampleRequestTradeID) 
AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)
END


BEGIN
IF @Sample = 0
	UPDATE pSampleRequestSpecItemBOM SET Size0 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample  = 1
	UPDATE pSampleRequestSpecItemBOM SET Size1 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 2
	UPDATE pSampleRequestSpecItemBOM SET Size2 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 3
	UPDATE pSampleRequestSpecItemBOM SET Size3 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 4
	UPDATE pSampleRequestSpecItemBOM SET Size4 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 5
	UPDATE pSampleRequestSpecItemBOM SET Size5 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 6
	UPDATE pSampleRequestSpecItemBOM SET Size6 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 7
	UPDATE pSampleRequestSpecItemBOM SET Size7 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 8
	UPDATE pSampleRequestSpecItemBOM SET Size8 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 9
	UPDATE pSampleRequestSpecItemBOM SET Size9 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 10
	UPDATE pSampleRequestSpecItemBOM SET Size10 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 11
	UPDATE pSampleRequestSpecItemBOM SET Size11 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 12
	UPDATE pSampleRequestSpecItemBOM SET Size12 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 13
	UPDATE pSampleRequestSpecItemBOM SET Size13 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 14
	UPDATE pSampleRequestSpecItemBOM SET Size14 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 15
	UPDATE pSampleRequestSpecItemBOM SET Size15 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 16
	UPDATE pSampleRequestSpecItemBOM SET Size16 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 17
	UPDATE pSampleRequestSpecItemBOM SET Size17 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 18
	UPDATE pSampleRequestSpecItemBOM SET Size18 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
ELSE IF @Sample = 19
	UPDATE pSampleRequestSpecItemBOM SET Size19 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND (SampleRequestTradeID = @SampleRequestTradeID) 
END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02416'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02416', GetDate())

END

GO
