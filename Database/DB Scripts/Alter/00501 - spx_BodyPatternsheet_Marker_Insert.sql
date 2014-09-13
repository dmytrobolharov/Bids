
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternsheet_Marker_Insert]    Script Date: 10/06/2010 12:31:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BodyPatternsheet_Marker_Insert') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BodyPatternsheet_Marker_Insert
GO

CREATE procedure [dbo].[spx_BodyPatternsheet_Marker_Insert] (
@ID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@CADDB varchar(50),
@Catalog varchar(50),
@Marker_Code int,
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime
)
AS
-- select getdate()

Declare @Linked as int
Declare @StyleID as UNIQUEIDENTIFIER
DECLARE @strCADMarker nvarchar(max)
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
BEGIN

Set @Linked = 1
Set @StyleID = null
set @CDate = getdate()
IF not exists  (select * from dbo.pBodyMarker where ID = @ID)

SET @SQLString1 = N'SELECT @Length1 = [Marker_Length] FROM ' + @CADDB + '.' + @Catalog + '.dbo.[Cad_Marker_Details]
			WHERE  Marker_Code = ' + Convert(varchar(50),@Marker_Code);
SET @ParmDefinition1 = N'@Length1 float OUTPUT';
SET @SQLString2 = N'SELECT @Marker_Plac_Bndl1 = [Marker_Plac_Bndl]  FROM ' + @CADDB + '.' + @Catalog + '.dbo.[Cad_Marker_Details]
				WHERE  Marker_Code = ' + Convert(varchar(50),@Marker_Code);
SET @ParmDefinition2 = N'@Marker_Plac_Bndl1 int OUTPUT';

EXECUTE sp_executesql @SQLString1, @ParmDefinition1,@Length OUTPUT;
EXECUTE sp_executesql @SQLString2,@ParmDefinition2,@Marker_Plac_Bndl OUTPUT;

set @Length2 = (Select @Length)
set @Marker_Plac_Bndl2 = (Select @Marker_Plac_Bndl)

Exec [spx_Body_Marker_CALCULATE] 

    @Length2, 
    @Marker_Plac_Bndl2 ,
	@Usage = @Usage1 OUTPUT  ,
	@LossFactor  = @LossFactor1 OUTPUT ,
	@pctLossFactor  = @pctLossFactor1 OUTPUT ,
	@TotalUsage  = @TotalUsage1 OUTPUT 
 
if (select @Usage1) is null
begin
set @Usage1 = ''
end
if (select @TotalUsage1) is null
begin
set @TotalUsage1 = ''
end
if (select @LossFactor1) is null
begin
set @LossFactor1 = ''
end
if (Select @pctLossFactor1) is null
begin
set @pctLossFactor1 = ''
end


IF not exists  (select * from dbo.pBodyMarker where ID = @ID)
SELECT @strCADMarker ='INSERT INTO dbo.pBodyMarker  ' +
'   SELECT '+  CHAR(39) + Convert(varchar(36),@ID) + CHAR(39) + 
' as ID, '+ CHAR(39) + Convert(varchar(36),@BodyID) + CHAR(39) + ' as BodyID 
	  ,null as StyleID 
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
       +CAST(@TotalUsage1  as varchar(200)) +' as TotalUsage, 
		null as AdjustedUsage
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
			, null as ImageID '
          +

' FROM ' +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Marker_Details WHERE  Marker_Code = ' + Convert(varchar(50),@Marker_Code)
select @strCADMarker
EXEC (@strCADMarker)
END
GO
----------------------------------------------------------------
----------------------------------------------------------------
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '501', GetDate())
GO
