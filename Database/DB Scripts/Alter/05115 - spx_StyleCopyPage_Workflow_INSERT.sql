/****** Object:  StoredProcedure [dbo].[spx_StyleCopyPage_Workflow_INSERT]    Script Date: 02/25/2013 17:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCopyPage_Workflow_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCopyPage_Workflow_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleCopyPage_Workflow_INSERT]    Script Date: 02/25/2013 17:26:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleCopyPage_Workflow_INSERT](
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@Map UNIQUEIDENTIFIER,
	@WorkflowItemID UNIQUEIDENTIFIER,
	@LinkImage INT,
	@StyleSet INT ,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser  NVARCHAR(200),
	@CDate DATETIME 
)
AS


IF @Map = '40000000-0000-0000-0000-000000000005' --	Development Spec

	EXECUTE spx_StyleDevelopmentSpecVariation_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate

ELSE IF @Map = '40000000-0000-0000-0000-000000000015' --	Size Construction

	EXEC spx_StyleDetailGridCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate

ELSE IF @Map = '40000000-0000-0000-0000-000000000006' --	Design Detail
BEGIN 
	
	EXECUTE spx_StyleDetailVariation_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate
	
END 
ELSE IF @Map = '40000000-0000-0000-0000-000000000013' --	Care

	EXEC spx_StyleCareCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate

ELSE IF @Map = '40000000-0000-0000-0000-000000000023'	--Style-Marker
BEGIN 

	INSERT INTO dbo.pBodyMarker( 
		ID ,BodyID ,StyleID ,Marker_Code ,Marker_Name ,Location ,Last_Updated ,IsActive ,IsLinkedBF ,IsLinked ,Usage ,LossFactor ,
		LossFactor_pct ,TotalUsage ,AdjustedUsage ,Marker_Description ,Marker_CrOpId ,Marker_Create ,Marker_RevOp1 ,
		CDate ,CUser ,MUser ,MDate ,
		Marker_Rev1 ,Marker_RevOp2 ,Marker_Rev2 ,Marker_Width ,Marker_Length ,Marker_Total_Perim ,Marker_Total_Area ,Marker_Goal ,
		Marker_Efficiency ,Marker_Notches ,Marker_Drillholes ,Marker_Corners ,Marker_Message ,Marker_nModels ,Marker_nPieces ,
		Marker_PlacPieces ,Marker_nSizes ,Marker_nBundles ,Marker_Plac_Bndl ,Marker_Bias ,Marker_Flip ,Marker_Nap ,Marker_NCEdits ,
		Marker_Spread ,Marker_Closed ,Marker_DieBlk ,Marker_Tubular ,Marker_StripePlaid ,Marker_nStripes ,Marker_nPlaids ,
		Marker_5_Star ,Marker_Max_Splice ,Marker_nSplices ,Marker_XVariance ,Marker_YVariance ,Marker_Image_SN ,Marker_Image_Name ,
		Marker_Comments ,CADCatId ,Category ,SubCat ,SubCatType ,Class ,UserDefined1 ,UserDefined2 ,UserDefined3 ,UserDefined4 ,UserDefined5 ,
		PreferMetric ,IsCosting ,IsApproved ,Sizes ,EfficiencyType ,LastCADRefresh ,PlotFileLocation ,NotchFile ,AnnotationFile ,StorageType ,
		mMarker_Width ,mMarker_Length ,mMarker_Total_Perim ,mMarker_Total_Area ,Yield_per_Bundle ,Yield_per_Dozen ,mYield_per_Bundle ,
		mYield_per_Dozen ,ImageID ,IsForAveraging ,StyleSet )
	SELECT 
		NEWID() AS ID,BodyID , @NewStyleID AS StyleID ,Marker_Code ,Marker_Name ,Location ,Last_Updated ,IsActive ,IsLinkedBF ,IsLinked ,Usage ,LossFactor ,
		LossFactor_pct ,TotalUsage ,AdjustedUsage ,Marker_Description ,Marker_CrOpId ,Marker_Create ,Marker_RevOp1 ,
		@CDate AS CDate,@CUser AS CUser, @CUser AS MUser ,@CDate AS MDate ,
		Marker_Rev1 ,Marker_RevOp2 ,Marker_Rev2 ,Marker_Width ,Marker_Length ,Marker_Total_Perim ,Marker_Total_Area ,Marker_Goal ,
		Marker_Efficiency ,Marker_Notches ,Marker_Drillholes ,Marker_Corners ,Marker_Message ,Marker_nModels ,Marker_nPieces ,
		Marker_PlacPieces ,Marker_nSizes ,Marker_nBundles ,Marker_Plac_Bndl ,Marker_Bias ,Marker_Flip ,Marker_Nap ,Marker_NCEdits ,
		Marker_Spread ,Marker_Closed ,Marker_DieBlk ,Marker_Tubular ,Marker_StripePlaid ,Marker_nStripes ,Marker_nPlaids ,
		Marker_5_Star ,Marker_Max_Splice ,Marker_nSplices ,Marker_XVariance ,Marker_YVariance ,Marker_Image_SN ,Marker_Image_Name ,
		Marker_Comments ,CADCatId ,Category ,SubCat ,SubCatType ,Class ,UserDefined1 ,UserDefined2 ,UserDefined3 ,UserDefined4 ,UserDefined5 ,
		PreferMetric ,IsCosting ,IsApproved ,Sizes ,EfficiencyType ,LastCADRefresh ,PlotFileLocation ,NotchFile ,AnnotationFile ,StorageType ,
		mMarker_Width ,mMarker_Length ,mMarker_Total_Perim ,mMarker_Total_Area ,Yield_per_Bundle ,Yield_per_Dozen ,mYield_per_Bundle ,
		mYield_per_Dozen ,ImageID ,IsForAveraging ,StyleSet
	FROM pBodyMarker
	WHERE StyleID = @StyleID
	

END 
ELSE IF @Map = '40000000-0000-0000-0000-000000000037'	--Style-Model
BEGIN 

	DECLARE 
		@ModelID UNIQUEIDENTIFIER,
		@TOTAL INT,
		@ROWID INT,
		@NewModelID UNIQUEIDENTIFIER
		
		
	CREATE TABLE #Model(
		ROWID INT IDENTITY(1,1), 
		ModelID UNIQUEIDENTIFIER
	)
	
	
	INSERT INTO #Model(ModelID)
	SELECT ID FROM pBodyPatternSheetModel
	WHERE StyleID = @StyleID

	
	SET @ROWID = 1 
	SELECT @TOTAL =  COUNT(*) FROM #Model
	
	WHILE @ROWID <= @TOTAL 
	BEGIN 
		SELECT @ModelID = ModelID FROM #Model WHERE ROWID = @ROWID	
		SET @NewModelID = NEWID()
		
		INSERT INTO dbo.pBodyPatternSheetModel( 
			ID ,BodyID ,StyleID ,StyleSet ,Model_Code ,Model_Name ,Last_Updated ,Active ,IsLinkedBF ,IsLinked ,
			CDate ,CUser ,MUser ,MDate ,
			Marker_Code ,Model_Description ,Model_CrOpId ,Model_Create ,
			Model_RevOp1 ,Model_Rev1 ,Model_RevOp2 ,Model_Rev2 ,Model_GRTable ,Model_MTMFile ,Model_SAName ,Model_SYNTable ,
			Model_HPTable ,Model_SampleSize ,Model_nMaterials ,Model_nPieces ,Model_nSizes ,Model_Image_SN ,Model_Image_Name ,
			Model_Comments ,PreferMetric ,UserDefined1 ,UserDefined2 ,UserDefined3 ,UserDefined4 ,UserDefined5 ,Total_Area ,
			LastCADRefresh ,PlotFileLocation ,NotchFile ,AnnotationFile ,StorageType ,ImageID)
		SELECT 
			@NewModelID AS ID ,BodyID ,@NewStyleID AS StyleID,StyleSet ,Model_Code ,Model_Name ,Last_Updated ,Active ,IsLinkedBF ,IsLinked ,
			@CDate AS CDate,@CUser AS CUser, @CUser AS MUser ,@CDate AS MDate ,
			Marker_Code ,Model_Description ,Model_CrOpId ,Model_Create ,
			Model_RevOp1 ,Model_Rev1 ,Model_RevOp2 ,Model_Rev2 ,Model_GRTable ,Model_MTMFile ,Model_SAName ,Model_SYNTable ,
			Model_HPTable ,Model_SampleSize ,Model_nMaterials ,Model_nPieces ,Model_nSizes ,Model_Image_SN ,Model_Image_Name ,
			Model_Comments ,PreferMetric ,UserDefined1 ,UserDefined2 ,UserDefined3 ,UserDefined4 ,UserDefined5 ,Total_Area ,
			LastCADRefresh ,PlotFileLocation ,NotchFile ,AnnotationFile ,StorageType ,ImageID
		FROM pBodyPatternSheetModel 
		WHERE StyleID = @StyleID AND ID = @ModelID
		
		

		INSERT INTO dbo.pBodyPatternSheetPiece( 
			ID ,StyleID ,StyleSet ,BodyID ,Piece_Code ,Piece_Name ,Last_Updated ,Active ,IsLinked ,Model_Code ,Material_Code ,Piece_Description ,
			Piece_Category ,Rule_Table_Name ,Piece_CrOpId ,Piece_Create ,Piece_RevOp1 ,Piece_Rev1 ,Piece_RevOp2 ,Piece_Rev2 ,Piece_Message ,
			Piece_HPTable ,Piece_Bias ,Piece_Flip ,Piece_Nap ,Piece_Ign_Splice ,Piece_Standard ,Piece_Buffering ,Piece_nSplits ,Piece_Tilt_CW ,
			Piece_DieBlock ,Piece_Pri_XBlock ,Piece_Pri_XBlkType ,Piece_Pri_YBlock ,Piece_Pri_YBlkType ,Piece_Sec_XBlock ,Piece_Sec_XBlkType ,
			Piece_Sec_YBlock ,Piece_Sec_YBlkType ,Piece_XVariance ,Piece_XVar_Type ,Piece_YVariance ,Piece_YVar_Type ,Piece_nUnflipped ,
			Piece_nOpposite ,Piece_nFilpY ,Piece_nFlipXY ,Piece_IsMirror ,Piece_Area ,Piece_Perimeter ,Piece_PreRotation ,Piece_Image_SN ,
			Piece_Image_Name ,Piece_Comments ,UserDefined1 ,UserDefined2 ,UserDefined3 ,UserDefined4 ,UserDefined5 ,Piece_Size ,Piece_Tilt_CCW ,
			Piece_CW_Type ,Piece_CCW_Type ,Piece_PreRotationType ,PiecePosition ,mPiece_Area ,mPiece_Perimeter ,ImageID ,ModelID )
		SELECT 
			NEWID() AS ID ,@NewStyleID AS StyleID,StyleSet ,BodyID ,Piece_Code ,Piece_Name ,Last_Updated ,Active ,IsLinked ,Model_Code ,Material_Code ,Piece_Description ,
			Piece_Category ,Rule_Table_Name ,Piece_CrOpId ,Piece_Create ,Piece_RevOp1 ,Piece_Rev1 ,Piece_RevOp2 ,Piece_Rev2 ,Piece_Message ,
			Piece_HPTable ,Piece_Bias ,Piece_Flip ,Piece_Nap ,Piece_Ign_Splice ,Piece_Standard ,Piece_Buffering ,Piece_nSplits ,Piece_Tilt_CW ,
			Piece_DieBlock ,Piece_Pri_XBlock ,Piece_Pri_XBlkType ,Piece_Pri_YBlock ,Piece_Pri_YBlkType ,Piece_Sec_XBlock ,Piece_Sec_XBlkType ,
			Piece_Sec_YBlock ,Piece_Sec_YBlkType ,Piece_XVariance ,Piece_XVar_Type ,Piece_YVariance ,Piece_YVar_Type ,Piece_nUnflipped ,
			Piece_nOpposite ,Piece_nFilpY ,Piece_nFlipXY ,Piece_IsMirror ,Piece_Area ,Piece_Perimeter ,Piece_PreRotation ,Piece_Image_SN ,
			Piece_Image_Name ,Piece_Comments ,UserDefined1 ,UserDefined2 ,UserDefined3 ,UserDefined4 ,UserDefined5 ,Piece_Size ,Piece_Tilt_CCW ,
			Piece_CW_Type ,Piece_CCW_Type ,Piece_PreRotationType ,PiecePosition ,mPiece_Area ,mPiece_Perimeter ,ImageID , @NewModelID AS ModelID
		FROM pBodyPatternSheetPiece  WHERE StyleID = @StyleID AND ModelID = @ModelID
		
	
		SET @ROWID =  @ROWID + 1 
	END 	

END
ELSE IF @Map = '40000000-0000-0000-0000-000000000023' -- Style-Marker
BEGIN
	EXEC spx_Style_Marker_Copy @StyleID = @StyleID, @NewStyleID=@NewStyleID, @MUser=@CUser, @MDate=@CDate
END
ELSE IF /*@Map = '40000000-0000-0000-0000-000000000018'  --Text-Image
	OR @Map = '80000000-0000-0000-0000-000000000008' -- Process Detail
	OR @Map = '40000000-0000-0000-0000-000000000050'  -- Grading Worksheet 
	OR @Map = '40000000-0000-0000-0000-000000000080' -- Dimensional BOM
	OR @Map = '40000000-0000-0000-0000-000000000078' -- BOL v.2
	AND */ @WorkflowItemID IS NOT NULL
BEGIN 

	EXECUTE spx_WorkflowItem_COPY 
		@WorkflowID = @Map,
		@WorkFlowItemId = @WorkFlowItemID,
		@StyleID = @NewStyleID,		--target
		@CopyStyleID = @StyleID,  --source
		@StyleSet = @StyleSet,
		@CopyStyleSet =  @StyleSet,
		@CUser = @CUser,
		@CDate = @CDate

END

 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05115', GetDate())
GO
