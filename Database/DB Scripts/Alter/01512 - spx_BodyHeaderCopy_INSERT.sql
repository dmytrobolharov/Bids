-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 8 June 2011                                                                                */
-- * WorkItem#2850                                                                                          */
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

/****** Object:  StoredProcedure [dbo].[spx_BodyHeaderCopy_INSERT]    Script Date: 05/25/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BodyHeaderCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BodyHeaderCopy_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BodyHeaderCopy_INSERT]    Script Date: 05/25/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BodyHeaderCopy_INSERT]      
(      
@BodyID uniqueidentifier,      
@NewBodyID uniqueidentifier,      
@DesignSketchID uniqueidentifier,      
@DesignSketchVersion varchar(5),        
@CreatedBy nvarchar(200),      
@CreatedDate datetime      
)      
AS      
      
SET NOCOUNT ON      
      
BEGIN      
 INSERT INTO pBody      
  (BodyID,BodyTypeID,BodySet,BodyNo,BodyWorkflowID,Description,TempID,TempNo,StyleCategory,SizeClass,SizeRange,POMTempID,    
POMTempItemID,Season,Year,ImageID,ImageVersion,PC1,PC2,PC3,PC4,Active,CUser,CDate,MUser,MDate,POMTempID1,POMTempID2,POMTempID3,POMTempID4,WashType     
  )      
 SELECT     @NewBodyID,BodyTypeID,BodySet,BodyNo,BodyWorkflowID,Description,TempID,TempNo,StyleCategory,SizeClass,SizeRange,POMTempID,    
POMTempItemID,Season,Year,@DesignSketchID,@DesignSketchVersion,PC1,PC2,PC3,PC4,Active,CUser,CDate,MUser,MDate,POMTempID1,POMTempID2,POMTempID3,POMTempID4,WashType        
 FROM  pBody WITH (NOLOCK)      
 WHERE BodyID = @BodyID      
END        
    
BEGIN      
      
 INSERT INTO pBodyImage      
 (BodyID,SpecSketchID1,SpecSketchVersion1,SpecSketchID2,SpecSketchVersion2,SpecSketchID3,SpecSketchVersion3,SpecSketchID4,SpecSketchVersion4)      
 SELECT @NewBodyID,SpecSketchID1,SpecSketchVersion1,SpecSketchID2,SpecSketchVersion2,SpecSketchID3,SpecSketchVersion3,SpecSketchID4,SpecSketchVersion4     
 FROM pBodyImage WITH (NOLOCK)      
 WHERE BodyID = @BodyID      
      
END      
    
      
BEGIN      
      
DECLARE @BodyworkflowID uniqueidentifier  
Set  @BodyworkflowID = newid()  
  
 INSERT INTO pBodyWorkflow      
 (BodyworkflowID,BodyID,BodySet,WorkflowID,WorkDate,WorkStart,WorkDue,WorkAssignedTo,WorkStatus,WorkSort,CUser,CDate,MUser,MDate,WorkDay)      
 SELECT NEWID(), @NewBodyID As BodyID,BodySet,WorkflowID,WorkDate,WorkStart,WorkDue,WorkAssignedTo,WorkStatus,WorkSort,@CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate ,WorkDay     
 FROM  pBodyWorkflow WITH (NOLOCK)      
 WHERE BodyID = @BodyID     
  
END      
      
      
      
BEGIN      
    

 INSERT INTO [pBodyPatternSheetModel]      
 ([ID],[BodyID],[StyleID],[StyleSet],[Model_Code],[Model_Name],[Last_Updated],[Active],[IsLinkedBF],[IsLinked],[CDate],[CUser],[MUser],[MDate],[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create],[Model_RevOp1],[Model_Rev1],[Model_SampleSize],[Model_nMaterials],[Model_nPieces],[Model_nSizes],[Model_Image_Name],[Model_Comments],[PreferMetric])      
 SELECT newid(), @NewBodyID As BodyID,[StyleID],[StyleSet],[Model_Code],[Model_Name],[Last_Updated],[Active],[IsLinkedBF],[IsLinked],@CreatedDate AS [CDate],@CreatedBy AS [CUser],@CreatedBy AS [MUser], @CreatedDate AS [MDate],[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create],[Model_RevOp1],[Model_Rev1],[Model_SampleSize],[Model_nMaterials],[Model_nPieces],[Model_nSizes],[Model_Image_Name],[Model_Comments],[PreferMetric]
 FROM  [pBodyPatternSheetModel] WITH (NOLOCK)      
 WHERE BodyID = @BodyID     
  
END  
      
BEGIN      
      
 
 INSERT INTO [pBodyMarker]      
 ([ID],[BodyID],[StyleID],[Marker_Code],[Marker_Name],[Location],[Last_Updated],[IsActive],[IsLinkedBF],[IsLinked],[Usage],[LossFactor],[LossFactor_pct],[TotalUsage],[AdjustedUsage],[Marker_Description],[Marker_CrOpId],[Marker_Create],[Marker_RevOp1],[CDate],[CUser],[MUser],[MDate],[Marker_Rev1],[Marker_RevOp2],[Marker_Rev2],[Marker_Width],[Marker_Length],[Marker_Total_Perim],[Marker_Total_Area],[Marker_Goal],[Marker_Efficiency],[Marker_Notches],[Marker_Drillholes],[Marker_Corners],[Marker_Message],[Marker_nModels],[Marker_nPieces],[Marker_PlacPieces],[Marker_nSizes],[Marker_nBundles],[Marker_Plac_Bndl],[Marker_Bias],[Marker_Flip],[Marker_Nap],[Marker_NCEdits],[Marker_Spread],[Marker_Closed],[Marker_DieBlk],[Marker_Tubular],[Marker_StripePlaid],[Marker_nStripes],[Marker_nPlaids],[Marker_5_Star],[Marker_Max_Splice],[Marker_nSplices],[Marker_XVariance],[Marker_YVariance],[Marker_Image_SN],[Marker_Image_Name],[Marker_Comments],[CADCatId],[Category],[SubCat],[SubCatType],[Class],[UserDefined1],[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[PreferMetric],[IsCosting],[IsApproved],[Sizes],[EfficiencyType],[LastCADRefresh],[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType],[mMarker_Width],[mMarker_Length],[mMarker_Total_Perim],[mMarker_Total_Area],[Yield_per_Bundle],[Yield_per_Dozen],[mYield_per_Bundle],[mYield_per_Dozen],[ImageID],[IsForAveraging],[StyleSet])      
 SELECT newid(), @NewBodyID As BodyID,[StyleID],[Marker_Code],[Marker_Name],[Location],[Last_Updated],[IsActive],[IsLinkedBF],[IsLinked],[Usage],[LossFactor],[LossFactor_pct],[TotalUsage],[AdjustedUsage],[Marker_Description],[Marker_CrOpId],[Marker_Create],[Marker_RevOp1],@CreatedDate AS [CDate],@CreatedBy AS [CUser],@CreatedBy AS [MUser], @CreatedDate AS [MDate],[Marker_Rev1],[Marker_RevOp2],[Marker_Rev2],[Marker_Width],[Marker_Length],[Marker_Total_Perim],[Marker_Total_Area],[Marker_Goal],[Marker_Efficiency],[Marker_Notches],[Marker_Drillholes],[Marker_Corners],[Marker_Message],[Marker_nModels],[Marker_nPieces],[Marker_PlacPieces],[Marker_nSizes],[Marker_nBundles],[Marker_Plac_Bndl],[Marker_Bias],[Marker_Flip],[Marker_Nap],[Marker_NCEdits],[Marker_Spread],[Marker_Closed],[Marker_DieBlk],[Marker_Tubular],[Marker_StripePlaid],[Marker_nStripes],[Marker_nPlaids],[Marker_5_Star],[Marker_Max_Splice],[Marker_nSplices],[Marker_XVariance],[Marker_YVariance],[Marker_Image_SN],[Marker_Image_Name],[Marker_Comments],[CADCatId],[Category],[SubCat],[SubCatType],[Class],[UserDefined1],[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[PreferMetric],[IsCosting],[IsApproved],[Sizes],[EfficiencyType],[LastCADRefresh],[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType],[mMarker_Width],[mMarker_Length],[mMarker_Total_Perim],[mMarker_Total_Area],[Yield_per_Bundle],[Yield_per_Dozen],[mYield_per_Bundle],[mYield_per_Dozen],[ImageID],[IsForAveraging],[StyleSet]
 FROM  [pBodyMarker] WITH (NOLOCK)      
 WHERE BodyID = @BodyID     
  
END   
/**************************************************************************************************************************************************************************************************************************************************************
  
    
*****************************************************      
-- INSERT LOG RECCORD       
***************************************************************************************************************************************************************************************************************************************************************
  
    
****************************************************/      
DECLARE @BodyNo NVARCHAR(20)      
DECLARE @Description NVARCHAR (4000)      
      
SELECT @BodyNo  = BodyNo        
FROM pBody WITH (NOLOCK) WHERE BodyID = @BodyID       
      
SET  @Description  = 'Body copied from body with BodyNo: '  +  @BodyNo        
       
INSERT INTO pBodyChange (BodyChangeID ,  BodyStatus ,  WorkflowID , BodyID , BodySet ,  BodyChangeNotifyTo , BodyChangeType,       
BodyChangeDescription ,  BodyChangeBy, BodyChangeDate,  ActiveID ,  Active  )       
VALUES  ( NEWID() ,   0 , '11111111-0000-0000-0000-000000000001' , @NewBodyID , 0 ,  '' , 'Information', @Description ,      
@CreatedBy,  @CreatedDate ,  '00000000-0000-0000-0000-000000000000'  , 1 ) 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01512', GetDate())

GO 