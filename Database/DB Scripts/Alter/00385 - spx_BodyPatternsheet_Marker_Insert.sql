
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternsheet_Marker_Insert]    Script Date: 09/10/2010 15:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_BodyPatternsheet_Marker_Insert') and sysstat & 0xf = 4)
    drop procedure spx_BodyPatternsheet_Marker_Insert
GO

CREATE procedure spx_BodyPatternsheet_Marker_Insert (
@ID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@Marker_Code int,
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime
)
AS

Declare @Linked as int
Declare @StyleID as UNIQUEIDENTIFIER
BEGIN

Set @Linked = 1
Set @StyleID = null
IF not exists  (select * from dbo.pBodyMarker where ID = @ID)

Declare @Usage1 float
Declare @LossFactor1 float
Declare @pctLossFactor1 float
Declare @TotalUsage1 float
Declare @Length as float
Declare @Marker_Plac_Bndl as int
set @Length = (SELECT [Marker_Length] FROM Cad_Marker_Details
				WHERE  Marker_Code = @Marker_Code)
set @Marker_Plac_Bndl = (SELECT [Marker_Plac_Bndl] FROM Cad_Marker_Details
				WHERE  Marker_Code = @Marker_Code)
Exec [spx_Body_Marker_CALCULATE] 

    @Length, 
    @Marker_Plac_Bndl ,
	@Usage = @Usage1 OUTPUT  ,
	@LossFactor  = @LossFactor1 OUTPUT ,
	@pctLossFactor  = @pctLossFactor1 OUTPUT ,
	@TotalUsage  = @TotalUsage1 OUTPUT  

INSERT INTO dbo.pBodyMarker
SELECT @ID as ID,@BodyID as BodyID 
	  ,@StyleID as StyleID 
      ,[Marker_Code]
      ,[Marker_Name]
      ,[Location]
      ,[Last_Updated]
      ,1 as [IsActive]
	   ,null as [IsLinkedBF]
       ,1 as [IsLinked]
       ,Usage = @Usage1
       ,LossFactor = @LossFactor1 
       ,LossFactor_pct = @pctLossFactor1
       ,TotalUsage = @TotalUsage1 
       ,null as AdjustedUsage
           ,[Marker_Description]
           ,[Marker_CrOpId]
           ,[Marker_Create]
           ,[Marker_RevOp1]
           ,@CDate as [CDate]
           ,@CUser as [CUser]
		   ,@MUser as [MUser]
           ,@MDate as [MDate]
           ,[Marker_Rev1]
           ,[Marker_RevOp2]
           ,[Marker_Rev2]
           ,[Marker_Width]
           ,[Marker_Length]
           ,[Marker_Total_Perim]
           ,[Marker_Total_Area]
           ,[Marker_Goal]
           ,[Marker_Efficiency]
           ,[Marker_Notches]
           ,[Marker_Drillholes]
           ,[Marker_Corners]
           ,[Marker_Message]
           ,[Marker_nModels]
           ,[Marker_nPieces]
           ,[Marker_PlacPieces]
           ,[Marker_nSizes]
           ,[Marker_nBundles]
           ,[Marker_Plac_Bndl]
           ,[Marker_Bias]
           ,[Marker_Flip]
           ,[Marker_Nap]
           ,[Marker_NCEdits]
           ,[Marker_Spread]
           ,[Marker_Closed]
           ,[Marker_DieBlk]
           ,[Marker_Tubular]
           ,[Marker_StripePlaid]
           ,[Marker_nStripes]
           ,[Marker_nPlaids]
           ,[Marker_5_Star]
           ,[Marker_Max_Splice]
           ,[Marker_nSplices]
           ,[Marker_XVariance]
           ,[Marker_YVariance]
           ,[Marker_Image_SN]
           ,[Marker_Image_Name]
           ,[Marker_Comments]
           ,[CADCatId]
           ,[Category]
           ,[SubCat]
           ,[SubCatType]
           ,[Class]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[PreferMetric]
           ,[IsCosting]
           ,[IsApproved]
           ,[Sizes]
           ,[EfficiencyType]
           ,[LastCADRefresh]
           ,[PlotFileLocation]
           ,[NotchFile]
           ,[AnnotationFile]
           ,[StorageType]
           ,[mMarker_Width]
           ,[mMarker_Length]
           ,[mMarker_Total_Perim]
           ,[mMarker_Total_Area]
           ,[Yield_per_Bundle]
           ,[Yield_per_Dozen]
           ,[mYield_per_Bundle]
           ,[mYield_per_Dozen] 
           

FROM Cad_Marker_Details
WHERE  Marker_Code = @Marker_Code



END
GO
----------------------------------------------------------------
----------------------------------------------------------------
-------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '385', GetDate())
GO