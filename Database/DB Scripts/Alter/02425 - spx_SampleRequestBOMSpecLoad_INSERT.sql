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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecLoad_INSERT]    Script Date: 12/18/2011 18:45:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecLoad_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecLoad_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecLoad_INSERT]    Script Date: 12/18/2011 18:45:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecLoad_INSERT]  
(  
@SpecPageID nvarchar(50),  
@SampleRequestWorkflowID nvarchar(50),  
@SampleRequestTradeID nvarchar(50),  
@SampleWorkflowID nvarchar(50),  
@TradePartnerVendorID nvarchar(50),  
@StyleID nvarchar(50),  
@StyleSet nvarchar(5),  
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@Submit nvarchar(50),          
@UserName nvarchar(50),  
@UserDate datetime  
)  
  
AS   
  
DECLARE @Sample DECIMAL(18,4), @WorkflowID nvarchar(50),  @SpecPageSubmit nvarchar(5)  
  
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
        END) FROM pSampleRequestSpecSizeBOM WITH (NOLOCK)  
 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID   
 AND SampleRequestTradeID = @SampleRequestTradeID   
 AND SampleWorkflowID = @SampleWorkflowID   
 And @ItemDim1Id = ItemDim1Id 
 AND @ItemDim2Id = ItemDim2Id 
 AND @ItemDim3Id = ItemDim3Id
 AND StyleID = @StyleID   
 AND StyleSet = @StyleSet  
END  
  
BEGIN  
  
 DELETE FROM pSampleRequestSpecItemBOM  
 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID   
 AND SampleRequestTradeID = @SampleRequestTradeID   
 AND SampleWorkflowID = @SampleWorkflowID   
 And @ItemDim1Id = ItemDim1Id 
 AND @ItemDim2Id = ItemDim2Id 
 AND @ItemDim3Id = ItemDim3Id 
 AND StyleID = @StyleID   
 AND StyleSet = @StyleSet  
 AND Submit = @Submit  
  
IF @SpecPageID = '00000000-0000-0000-0000-000000000000'  
  
 BEGIN  
   
  DECLARE @POMTempID uniqueidentifier  
  IF @StyleSet = 1 SELECT @POMTempID = POMTempID1 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID   
  IF @StyleSet = 2 SELECT @POMTempID = POMTempID2 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID   
  IF @StyleSet = 3 SELECT @POMTempID = POMTempID3 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID   
  IF @StyleSet = 4 SELECT @POMTempID = POMTempID4 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID    
   
   
  INSERT INTO dbo.pSampleRequestSpecItemBOM  
   (SampleRequestWorkflowID, TradePartnerVendorID, SampleWorkflowID, SampleRequestTradeID, ItemDim1Id,ItemDim2Id,ItemDim3Id, SpecID, StyleID, StyleSet, POM, PointMeasur, TOL, Ask, Spec,   
   Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19,   
   Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,   
   Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19,   
   CDate, CUser, MDate, MUser, Change, Submit, Final, Rev, [Var], SpecMasterID, POMTempItemID, POMLibraryID, POMTempID, Critical,   
   TOLN, Sort, HowToMeasurText, HowToMeasurImage, Sample)  
  SELECT  @SampleRequestWorkflowID AS SampleRequestWorkflowID, @TradePartnerVendorID AS TradePartnerVendorID, @SampleWorkflowID AS SampleWorkflowID,   
   @SampleRequestTradeID AS SampleRequestTradeID,  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, SpecID, StyleID, StyleSet, POM, PointMeasur, TOL, Spec AS Ask, 0 AS Spec,   
   Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19,   
   Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,   
   0 AS Size0, 0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11,   
   0 AS Size12, 0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19,  
   @UserDate AS CDate, @UserName AS CUser, @UserDate AS MDate,   
   @UserName AS MUser, Change, @Submit AS Submit, 0 AS Final, 0 AS Rev, 0 AS [VAR], SpecMasterID, POMTempItemID, POMLibraryID, POMTempID,   
   Critical, TOLN, Sort, HowToMeasurText, HowToMeasurImage , @Sample 
  FROM dbo.pStyleSpec WITH (NOLOCK)  
  WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet)  
 END  
   
ELSE  
  
 BEGIN  
   
 DECLARE @NewSubmit varchar(5)  
 DECLARE @NewStatus varchar(5)  
   
 SELECT @NewSubmit = MAX(Submit) FROM pSampleRequestSubmitBOM WITH (NOLOCK)   
 WHERE SampleRequestWorkflowID = @SpecPageID  
 AND SampleRequestTradeID = @SampleRequestTradeID   
 AND TradePartnerVendorID = @TradePartnerVendorID  
 And @ItemDim1Id = ItemDim1Id 
 AND @ItemDim2Id = ItemDim2Id 
 AND @ItemDim3Id = ItemDim3Id   
 AND StyleID = @StyleID  
 AND StyleSet = @StyleSet  
   
 SELECT @NewStatus = Status FROM pSampleRequestSubmitBOM WITH (NOLOCK)   
 WHERE SampleRequestWorkflowID = @SpecPageID  
 AND SampleRequestTradeID = @SampleRequestTradeID   
 AND TradePartnerVendorID = @TradePartnerVendorID  
 And @ItemDim1Id = ItemDim1Id 
 AND @ItemDim2Id = ItemDim2Id 
 AND @ItemDim3Id = ItemDim3Id   
 AND StyleID = @StyleID  
 AND StyleSet = @StyleSet   
 AND Submit = @NewSubmit  
   
 IF @NewStatus = 2 OR @NewStatus = 3  
  BEGIN  
   INSERT INTO dbo.pSampleRequestSpecItemBOM  
   (SampleRequestSpecSizeID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, Submit, TradePartnerVendorID, SpecID, StyleID,   
   ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, POM, PointMeasur, TOL, Ask, Spec, [Var], Rev, Final,   
   Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19,   
    Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,   
    Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19,   
   CDate, CUser, MDate, MUser, Change, SpecMasterID, POMTempItemID,   
   POMLibraryID, POMTempID, Critical, TOLN, Sort, HowToMeasurText, HowToMeasurImage, Sample)  
  SELECT     SampleRequestSpecSizeID, SampleRequestTradeID, @SampleRequestWorkflowID AS SampleRequestWorkflowID,   
   @SampleWorkflowID AS SampleWorkflowID, @Submit AS Submit, TradePartnerVendorID, SpecID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, POM, PointMeasur,   
   TOL, Final AS Ask, 0 AS Spec, 0 AS [VAR], 0 AS Rev, Final,   
   Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19,   
   Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,   
   0 AS Size0, 0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11,   
   0 AS Size12, 0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19,  
   CDate, CUser, MDate, MUser, Change,   
   SpecMasterID, POMTempItemID, POMLibraryID, POMTempID, Critical, TOLN, Sort, HowToMeasurText, HowToMeasurImage , @Sample 
  FROM  dbo.pSampleRequestSpecItemBOM WITH (NOLOCK)  
  WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SpecPageID) AND (Submit = @NewSubmit)  
  END  
 ELSE  
  BEGIN  
  INSERT INTO dbo.pSampleRequestSpecItemBOM  
   (SampleRequestSpecSizeID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, Submit, TradePartnerVendorID, SpecID, StyleID,   
   ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, POM, PointMeasur, TOL, Ask, Spec, [Var], Rev, Final,   
   Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19,   
    Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,   
    Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19,   
   CDate, CUser, MDate, MUser, Change, SpecMasterID, POMTempItemID,   
   POMLibraryID, POMTempID, Critical, TOLN, Sort, HowToMeasurText, HowToMeasurImage, Sample)  
  SELECT     SampleRequestSpecSizeID, SampleRequestTradeID, @SampleRequestWorkflowID AS SampleRequestWorkflowID,   
   @SampleWorkflowID AS SampleWorkflowID, @Submit AS Submit, TradePartnerVendorID, SpecID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, POM, PointMeasur,   
   TOL, Rev AS Ask, 0 AS Spec, 0 AS [VAR], 0 AS Rev, Final,   
   Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, Proto19,   
   Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,   
   0 AS Size0, 0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11,   
   0 AS Size12, 0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19,  
   CDate, CUser, MDate, MUser, Change,   
   SpecMasterID, POMTempItemID, POMLibraryID, POMTempID, Critical, TOLN, Sort, HowToMeasurText, HowToMeasurImage, @Sample  
  FROM  dbo.pSampleRequestSpecItemBOM WITH (NOLOCK)  
  WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SpecPageID) AND (Submit = @NewSubmit)  
  END  
 END   
  
END  


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02425'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02425', GetDate())

END

GO
