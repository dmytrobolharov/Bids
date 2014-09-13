IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_Insert]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Style_Marker_Insert]
GO
/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_Insert]    Script Date: 03/28/2011 11:36:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[spx_Style_Marker_Insert] (
@ID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER ,
@StyleSet int,
@CADDB varchar(50),
@Catalog varchar(50),
@Marker_Code int,
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime
)
AS
Declare @Linked as int
Declare @BodyID as UNIQUEIDENTIFIER
DECLARE @strCADMarker nvarchar(max)
Set @Linked = 1
Set @BodyID = null
Declare @Usage float
Declare @Usage1 float
Declare @LossFactor1 float
Declare @pctLossFactor1 float
Declare @TotalUsage1 float
DECLARE @ParmDefinition1 nvarchar(500)
DECLARE @ParmDefinition2 nvarchar(500)
DECLARE @Length float
DECLARE @Length2 float
DECLARE @Marker_Plac_Bndl int
DECLARE @Marker_Plac_Bndl2 int
DECLARE @SQLString1 nvarchar(max)
DECLARE @SQLString2 nvarchar(max)
IF not exists  (select * from dbo.pBodyMarker where ID = @ID)

BEGIN

	SET @SQLString1 = 'select  @Length1=Round(COALESCE(Marker_Length,0),4), @Marker_Plac_Bndl1 = [Marker_Plac_Bndl] from ' + @CADDB + '.' + @Catalog + 
		'.dbo.[Cad_Marker_Details] WHERE  Marker_Code = ' + Convert(varchar(50),@Marker_Code); 
	SET @ParmDefinition1 = N'@Length1 float OUTPUT, @Marker_Plac_Bndl1 int OUTPUT';


	EXECUTE sp_executesql @SQLString1, @ParmDefinition1, @Length1=@Length2 OUTPUT, @Marker_Plac_Bndl1=@Marker_Plac_Bndl2 OUTPUT;

	--select @Marker_Code as Marker_Code;
	--SELECT @Length2 as Length2;
	--SELECT @Marker_Plac_Bndl2 as Marker_Plac_Bndl2;

	-- calculate the Usage
	if ((@Marker_Plac_Bndl2 is not null) and  (@Length2 is not null))
		begin
			if (@Marker_Plac_Bndl2 > 0 and @Length2 > 0)
				begin
					set @Usage1 = @Length2/@Marker_Plac_Bndl2
					set @Usage1 = ROUND(@Usage1,4)
				end
			else
				begin
					set @Usage1 = 0
				end
		end
	else
		begin
			set @Usage1 = 0
		end	
		
	if (@Usage1=0)
		begin
			set @pctLossFactor1=0	
			set @LossFactor1=0
			set @TotalUsage1 =0
		end		
	else
		begin 
			set @pctLossFactor1=0	
			set @LossFactor1=0
			set @TotalUsage1 = @Usage1
		end
		

SELECT @strCADMarker ='INSERT INTO dbo.[pBodyMarker]
           ([ID]
           ,[StyleID]
           ,[StyleSet]
           ,[Marker_Code]
           ,[Marker_Name]
           ,[Location]
           ,[Last_Updated]
           ,[IsActive]
           ,[IsLinkedBF]
           ,[IsLinked]
           ,[Usage]
           ,[LossFactor]
           ,[LossFactor_pct]
           ,[TotalUsage]
           ,[Marker_Description]
           ,[Marker_CrOpId]
           ,[Marker_Create]
           ,[Marker_RevOp1]
           ,[CDate]
           ,[CUser]
           ,[MUser]
           ,[MDate]
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
           )  ' 
Select @SQLString2 =
'   SELECT '+  CHAR(39) + Convert(varchar(36),@ID) + CHAR(39) + 
' as ID, '+ CHAR(39) + Convert(varchar(36),@StyleID) + CHAR(39) + ' as StyleID 
	  , '+ CAST(@StyleSet as varchar(4)) + ' as StyleSet    
      ,[Marker_Code]
      ,[Marker_Name]
      ,[Location]
      ,[Last_Updated]
      ,1 as [IsActive]
	   ,0 as [IsLinkedBF]
       ,1 as [IsLinked], '
        + CAST(@Usage1 as varchar(200)) + ' as Usage,'
       + CAST(@LossFactor1 as varchar(200))+ ' as LossFactor, '
       +CAST(@pctLossFactor1 as varchar(200))+' as LossFactor_pct, '
       +CAST(@TotalUsage1  as varchar(200)) +' as TotalUsage
           ,[Marker_Description]
           ,[Marker_CrOpId]
           ,[Marker_Create]
           ,[Marker_RevOp1]
           , '+ convert(nvarchar(50), CAST(@CDate AS DATETIME), 101) +' as [CDate], ' +
           CHAR(39) + Convert(varchar(36),@CUser) + CHAR(39) +' as [CUser], '+
		   CHAR(39) + Convert(varchar(36),@MUser) + CHAR(39) + ' as [MUser], '+
           convert(nvarchar(50), CAST(@CDate AS DATETIME), 101)  + ' as [MDate], '+
           '[Marker_Rev1]
           ,[Marker_RevOp2]
           ,[Marker_Rev2]
           ,Round(COALESCE(Marker_Width, 0),4)
           ,Round(COALESCE(Marker_Length,0),4)
           ,Round(COALESCE(Marker_Total_Perim,0),4)
           ,Round(COALESCE(Marker_Total_Area,0),4)
           ,[Marker_Goal]
           ,Round(COALESCE(Marker_Efficiency,0),4)
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
           ,[mYield_per_Dozen]'
          + ' FROM ' +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Marker_Details WHERE  Marker_Code = ' + Convert(varchar(50),@Marker_Code)

EXEC (@strCADMarker + @SQLString2)


END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01422', GetDate())

GO	
	