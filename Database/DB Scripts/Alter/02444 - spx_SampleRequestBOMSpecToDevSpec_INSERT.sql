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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecToDevSpec_INSERT]    Script Date: 12/18/2011 18:59:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecToDevSpec_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecToDevSpec_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecToDevSpec_INSERT]    Script Date: 12/18/2011 18:59:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecToDevSpec_INSERT]
(@SampleRequestTradeID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@Submit int,
@StyleID uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleSet int)
AS 



SET NoCount ON
	
BEGIN TRANSACTION

		DELETE FROM pStyleSpec WHERE   (StyleID = @StyleID) AND (StyleSet = @StyleSet)

		IF @@ERROR <> 0
		BEGIN
		ROLLBACK TRANSACTION
		RETURN
		END	

		BEGIN

		INSERT INTO pStyleSpec
			(SpecID, SpecMasterID, POMTempItemID, POMLibraryID, ModelSpecID, ModelID, POMTempID, StyleID, StyleSet, POM, PointMeasur, Critical, TOL, 
			TOLN, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, 
			Proto16, Proto17, Proto18, Proto19, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, 
			Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, 
			Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, HowToMeasurText, 
			HowToMeasurImage)
		SELECT SpecID, SpecMasterID, POMTempItemID, POMLibraryID, ModelSpecID, ModelID, POMTempID, StyleID, StyleSet, POM, PointMeasur, Critical, TOL, 
			TOLN, Proto0 AS Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, 
			Proto16, Proto17, Proto18, Proto19, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, 
			Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, 
			Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, HowToMeasurText, 
			HowToMeasurImage
		FROM  pSampleRequestSpecItemBOM WITH (NOLOCK)
		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (Submit = @Submit) AND 
		(StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet)
		
		
		IF @@ERROR <> 0
		BEGIN
		ROLLBACK TRANSACTION
		RETURN
		END	

END

COMMIT TRANSACTION


		UPDATE pSampleRequestSpecItemBOM SET
			pSampleRequestSpecItemBOM.Critical = pStyleSpec.Critical,
			pSampleRequestSpecItemBOM.POMTempID = pStyleSpec.POMTempID,
			pSampleRequestSpecItemBOM.POMTempItemID = pStyleSpec.POMTempItemID,
			pSampleRequestSpecItemBOM.POMLibraryID = pStyleSpec.POMLibraryID    
		FROM  pSampleRequestSpecItemBOM WITH (nolock) INNER JOIN
			pStyleSpec WITH (nolock) ON pSampleRequestSpecItemBOM.StyleID = pStyleSpec.StyleID AND 
			pSampleRequestSpecItemBOM.StyleSet = pStyleSpec.StyleSet AND 
			pSampleRequestSpecItemBOM.POM = pStyleSpec.POM
		WHERE (pSampleRequestSpecItemBOM.StyleId = @StyleId) AND (pSampleRequestSpecItemBOM.StyleSet = @StyleSet)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02444'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02444', GetDate())

END

GO

