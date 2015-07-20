/****** Object:  StoredProcedure [dbo].[spx_Style_Model_Copy]    Script Date: 03/14/2013 12:15:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Model_Copy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Model_Copy]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_Model_Copy]    Script Date: 03/14/2013 12:15:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_Style_Model_Copy] (
@StyleID UNIQUEIDENTIFIER,
@NewStyleID UNIQUEIDENTIFIER,
@MUser nvarchar(200),
@MDate datetime
)
AS
BEGIN


INSERT INTO [pBodyPatternSheetModel]
           ([ID]
           ,[BodyID]
           ,[StyleID]
           ,[StyleSet]
           ,[Model_Code]
           ,[Model_Name]
           ,[Last_Updated]
           ,[Active]
           ,[IsLinkedBF]
           ,[IsLinked]
           ,[CDate]
           ,[CUser]
           ,[MUser]
           ,[MDate]
           ,[Marker_Code]
           ,[Model_Description]
           ,[Model_CrOpId]
           ,[Model_Create]
           ,[Model_RevOp1]
           ,[Model_Rev1]
           ,[Model_RevOp2]
           ,[Model_Rev2]
           ,[Model_GRTable]
           ,[Model_MTMFile]
           ,[Model_SAName]
           ,[Model_SYNTable]
           ,[Model_HPTable]
           ,[Model_SampleSize]
           ,[Model_nMaterials]
           ,[Model_nPieces]
           ,[Model_nSizes]
           ,[Model_Image_SN]
           ,[Model_Image_Name]
           ,[Model_Comments]
           ,[PreferMetric]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[Total_Area]
           ,[LastCADRefresh]
           ,[PlotFileLocation]
           ,[NotchFile]
           ,[AnnotationFile]
           ,[StorageType]
           ,[ImageID])
SELECT	NEWID()
		,[BodyID]
		,@NewStyleID as StyleID
		,StyleSet
		,[Model_Code]
		,[Model_Name]
		,[Last_Updated]
		,[Active]
		,[IsLinkedBF]
		,[IsLinked]
		,@MDate as [CDate]
		,@MUser as [CUser]
		,@MUser as [MUser]
		,@MDate as [MDate]          
		,[Marker_Code]
		,[Model_Description]
		,[Model_CrOpId]
		,[Model_Create]
		,[Model_RevOp1]
		,[Model_Rev1]
		,[Model_RevOp2]
		,[Model_Rev2]
		,[Model_GRTable]
		,[Model_MTMFile]
		,[Model_SAName]
		,[Model_SYNTable]
		,[Model_HPTable]
		,[Model_SampleSize]
		,[Model_nMaterials]
		,[Model_nPieces]
		,[Model_nSizes]
		,[Model_Image_SN]
		,[Model_Image_Name]
		,[Model_Comments]
		,[PreferMetric]
		,[UserDefined1]
		,[UserDefined2]
		,[UserDefined3]
		,[UserDefined4]
		,[UserDefined5]
		,[Total_Area]
		,[LastCADRefresh]
		,[PlotFileLocation]
		,[NotchFile]
		,[AnnotationFile]
		,[StorageType]
		,[ImageID]
FROM [pBodyPatternSheetModel] WHERE StyleID = @StyleID
AND Model_Code NOT IN (SELECT Model_Code FROM pBodyPatternSheetModel WHERE StyleID = @NewStyleID)

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05295', GetDate())
