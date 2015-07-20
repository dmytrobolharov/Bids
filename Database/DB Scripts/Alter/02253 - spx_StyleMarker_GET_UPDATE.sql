IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMarker_GET_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMarker_GET_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleMarker_GET_UPDATE]    Script Date: 11/29/2011 17:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create  PROC  [dbo].[spx_StyleMarker_GET_UPDATE]
(
@CADDB nvarchar(50),
@Catalog nvarchar(50),
@StyleID uniqueidentifier,
@StyleSet int,
@strSortOrder nvarchar(50),
@Imperial NVarChar(2),
@LossFactorenabled NVarChar(10)
)
AS

declare @ID uniqueidentifier
declare @Marker_Code int
declare @Sortsql   nvarchar(max)
declare @strCADsql nvarchar(max)
Declare @SortColumn nvarchar(50)

SELECT ROW_NUMBER() OVER(ORDER BY Marker_Code DESC) AS 'rownum', * 
into #tempTblBody
FROM pBodyMarker where StyleID = @StyleID AND StyleSet = @StyleSet and IsLinked = 1

--SELECT * from #tempTblBody

declare @RowCnt int
declare @MaxRows int
select @RowCnt = 1
select @MaxRows=count(*) from #tempTblBody

--select @MaxRows as MaxRows
--select len(@Imperial) as Imperial

while @RowCnt <= @MaxRows

begin

	--Select @RowCnt as sRowCnt
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
	Declare @strCADMarker nvarchar(max)
	------------------------------------------------

	select @Marker_Code=Marker_Code, @StyleID=StyleID, @ID=ID, 
	@pctLossFactor1=LossFactor_pct, @LossFactor1=LossFactor from #tempTblBody where rownum = @RowCnt
	------------------------------------------------

	CREATE TABLE #tempTBLCAD
	(
		[Marker_Code] [int]  NULL DEFAULT (0),
		[Marker_Name] [varchar](64)  NULL,
		[Location] [varchar](510) NULL,
		[Last_Updated] [datetime] NULL,
		[IsActive] [int] NULL DEFAULT ((-1)),
		[IsLinked] [int] NULL DEFAULT (0),
		[ClassifierId] [int]  NULL,
		[SystemId] [int]  NULL DEFAULT (0),
		[Marker_Description] [varchar](510) NULL,
		[Marker_CrOpId] [varchar](100) NULL,
		[Marker_Create] [datetime] NULL,
		[Marker_RevOp1] [varchar](100) NULL,
		[Marker_Rev1] [datetime] NULL,
		[Marker_RevOp2] [varchar](100) NULL,
		[Marker_Rev2] [datetime] NULL,
		[Marker_Width] [float] NULL,
		[Marker_Length] [float] NULL,
		[Marker_Total_Perim] [float] NULL,
		[Marker_Total_Area] [float] NULL,
		[Marker_Goal] [float] NULL,
		[Marker_Efficiency] [float] NULL,
		[Marker_Notches] [int] NULL,
		[Marker_Drillholes] [int] NULL,
		[Marker_Corners] [int] NULL,
		[Marker_Message] [varchar](100) NULL,
		[Marker_nModels] [int] NULL,
		[Marker_nPieces] [int] NULL,
		[Marker_PlacPieces] [int] NULL,
		[Marker_nSizes] [int] NULL,
		[Marker_nBundles] [int] NULL,
		[Marker_Plac_Bndl] [int] NULL,
		[Marker_Bias] [int] NULL DEFAULT (0),
		[Marker_Flip] [int] NULL DEFAULT (0),
		[Marker_Nap] [int] NULL DEFAULT (0),
		[Marker_NCEdits] [int] NULL DEFAULT (0),
		[Marker_Spread] [int] NULL DEFAULT (0),
		[Marker_Closed] [int] NULL DEFAULT (0),
		[Marker_DieBlk] [int] NULL DEFAULT (0),
		[Marker_Tubular] [int] NULL DEFAULT (0),
		[Marker_StripePlaid] [int] NULL DEFAULT (0),
		[Marker_nStripes] [int] NULL,
		[Marker_nPlaids] [int] NULL,
		[Marker_5_Star] [int] NULL,
		[Marker_Max_Splice] [float] NULL,
		[Marker_nSplices] [int] NULL,
		[Marker_XVariance] [float] NULL,
		[Marker_YVariance] [float] NULL,
		[Marker_Image_SN] [int] NULL,
		[Marker_Image_Name] [varchar](510) NULL,
		[Marker_Comments] [ntext] NULL,
		[CADCatId] [int]  NULL,
		[Category] [varchar](100) NULL,
		[SubCat] [varchar](100) NULL,
		[SubCatType] [varchar](100) NULL,
		[Class] [varchar](100) NULL,
		[UserDefined1] [varchar](100) NULL,
		[UserDefined2] [varchar](100) NULL,
		[UserDefined3] [varchar](100) NULL,
		[UserDefined4] [varchar](100) NULL,
		[UserDefined5] [varchar](100) NULL,
		[PreferMetric] [int] NULL DEFAULT (0),
		[IsCosting] [int] NULL DEFAULT (0),
		[IsApproved] [int] NULL DEFAULT (0),
		[Sizes] [varchar](4000) NULL,
		[EfficiencyType] [int] NULL,
		[LastCADRefresh] [datetime] NULL,
		[PlotFileLocation] [varchar](510) NULL,
		[NotchFile] [varchar](100) NULL,
		[AnnotationFile] [varchar](100) NULL,
		[StorageType] [int] NULL,
		[mMarker_Width] [float] NULL,
		[mMarker_Length] [float] NULL,
		[mMarker_Total_Perim] [float] NULL,
		[mMarker_Total_Area] [float] NULL,
		[Yield_per_Bundle] [float] NULL,
		[Yield_per_Dozen] [float] NULL,
		[mYield_per_Bundle] [float] NULL,
		[mYield_per_Dozen] [float] NULL,
	)
	SELECT  @strCADsql = 'INSERT
	INTO #tempTBLCAD
	SELECT  Marker_Code, 
			Marker_Name, 
			Location, 
			Last_Updated, 
			IsActive, 
			IsLinked, 
			ClassifierId, 
			SystemId, 
			Marker_Description, 
			Marker_CrOpId, 
			Marker_Create, 
			Marker_RevOp1, 
			Marker_Rev1, 
			Marker_RevOp2, 
			Marker_Rev2, 
			Marker_Width, 
			Marker_Length, 
			Marker_Total_Perim, 
			Marker_Total_Area, 
			Marker_Goal, 
			Marker_Efficiency, 
			Marker_Notches, 
			Marker_Drillholes, 
			Marker_Corners, 
			Marker_Message, 
			Marker_nModels, 
			Marker_nPieces, 
			Marker_PlacPieces, 
			Marker_nSizes, 
			Marker_nBundles, 
			Marker_Plac_Bndl, 
			Marker_Bias, 
			Marker_Flip, 
			Marker_Nap, 
			Marker_NCEdits, 
			Marker_Spread, 
			Marker_Closed, 
			Marker_DieBlk, 
			Marker_Tubular, 
			Marker_StripePlaid, 
			Marker_nStripes, 
			Marker_nPlaids, 
			Marker_5_Star, 
			Marker_Max_Splice, 
			Marker_nSplices, 
			Marker_XVariance, 
			Marker_YVariance, 
			Marker_Image_SN, 
			Marker_Image_Name, 
			Marker_Comments, 
			CADCatId, 
			Category, 
			SubCat, 
			SubCatType, 
			Class, 
			UserDefined1, 
			UserDefined2, 
			UserDefined3, 
			UserDefined4, 
			UserDefined5, 
			PreferMetric, 
			IsCosting, 
			IsApproved, 
			Sizes, 
			EfficiencyType, 
			LastCADRefresh, 
			PlotFileLocation, 
			NotchFile, 
			AnnotationFile, 
			StorageType, 
			mMarker_Width, 
			mMarker_Length, 
			mMarker_Total_Perim, 
			mMarker_Total_Area, 
			Yield_per_Bundle, 
			Yield_per_Dozen, 
			mYield_per_Bundle, 
			mYield_per_Dozen 
	FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Marker_Details WHERE  Marker_Code  = ' + Convert(varchar(50),@Marker_Code )

	Exec (@strCADsql)

	--select * from #tempTBLCAD


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

	-- calculate the LossFactor when %pctLossfactor is editable.
	if (@LossFactorenabled = 'false')
		begin
			if (@Usage1<>0)
				begin
					if (@pctLossFactor1 is not null)
						begin
							if (@pctLossFactor1 > 1)
								begin
									set @LossFactor1=round(((@pctLossFactor1-1)*@Usage1),4)
								end
							else
								begin
									set @LossFactor1=0
								end
						end
					else
						begin				
							set @LossFactor1=0
						end
				end
		end
	
	-- calculate the %pctLossFactor when Lossfactor is editable.
	if (@LossFactorenabled = 'true')
		begin
			if (@Usage1<>0)
				begin
					if (@LossFactor1 is not null)
						begin
							if (@LossFactor1 = 0)
								begin
									set @pctLossFactor1=1						
								end
							else
								begin
									set @pctLossFactor1=round(1+(@LossFactor1/@Usage1),4)
								end
						end
					else
						begin
							set @pctLossFactor1=1				
						end
				end
		end
	
	
	if (@Usage1=0)
		begin
			set @pctLossFactor1=0	
			set @LossFactor1=0
		end

					
	set @TotalUsage1 = round((@Usage1+@LossFactor1),4)

	--select @Usage1 as Usage1						
	--select @pctLossFactor1 as pctLossFactor1	
	--select @LossFactor1 as LossFactor1
	--select @TotalUsage1 as  TotalUsage1

	/*
	Exec [spx_Body_Marker_CALCULATE] 

		@Length2, 
		@Marker_Plac_Bndl2  ,
		@Usage = @Usage1 OUTPUT  ,
		@LossFactor  = @LossFactor1 OUTPUT ,
		@pctLossFactor  = @pctLossFactor1 OUTPUT ,
		@TotalUsage  = @TotalUsage1 OUTPUT  
	*/

IF (SELECT COUNT(*) FROM #tempTBLCAD) > 0
BEGIN
	Update pBodyMarker
	SET	 
		  Marker_Code = (SELECT Marker_Code from  #tempTBLCAD) 
		  ,Marker_Name = (SELECT Marker_Name from  #tempTBLCAD )
		  ,Location = (SELECT Location from  #tempTBLCAD )
		  ,Last_Updated = (SELECT Last_Updated from  #tempTBLCAD )
		  ,IsActive = 1
		  ,IsLinked = 1
		   ,Usage = @Usage1
		   ,LossFactor = @LossFactor1 
		   ,LossFactor_pct = @pctLossFactor1
		   ,TotalUsage = @TotalUsage1 
	--       ,null as AdjustedUsage
		  ,Marker_Description = (SELECT Marker_Description from  #tempTBLCAD )
		  ,Marker_CrOpId = (SELECT Marker_CrOpId from  #tempTBLCAD )
		  ,Marker_Create = (SELECT Marker_Create from  #tempTBLCAD ) 
		  ,Marker_RevOp1 = (SELECT Marker_RevOp1 from  #tempTBLCAD )
	--      ,CDate = (SELECT CDate from  #tempTBLCAD )
	--      ,CUser = (SELECT CUser from  #tempTBLCAD )
	--      ,MDate = (SELECT MDate from  #tempTBLCAD )
	--      ,MUser = (SELECT MUser from  #tempTBLCAD )
		  ,Marker_Rev1 = (SELECT Marker_Rev1 from  #tempTBLCAD )
		  ,Marker_RevOp2 = (SELECT Marker_RevOp2 from  #tempTBLCAD )
		  ,Marker_Rev2 = (SELECT Marker_Rev2 from  #tempTBLCAD )      
		  ,Marker_Width = (SELECT Round(COALESCE(Marker_Width, 0),4) from  #tempTBLCAD )
		  ,Marker_Length = (SELECT Round(COALESCE(Marker_Length,0),4) from  #tempTBLCAD )
		  ,Marker_Total_Perim = (SELECT Round(COALESCE(Marker_Total_Perim,0),4) from  #tempTBLCAD )
		  ,Marker_Total_Area = (SELECT Round(COALESCE(Marker_Total_Area,0),4) from  #tempTBLCAD )
		  ,Marker_Goal = (SELECT Marker_Goal from  #tempTBLCAD )
		  ,Marker_Efficiency = (SELECT Round(COALESCE(Marker_Efficiency,0),4) from  #tempTBLCAD )
		  ,Marker_Notches = (SELECT Marker_Notches from  #tempTBLCAD )
		  ,Marker_Drillholes = (SELECT Marker_Drillholes from  #tempTBLCAD )
		  ,Marker_Corners = (SELECT Marker_Corners from  #tempTBLCAD )
		  ,Marker_Message = (SELECT Marker_Message from  #tempTBLCAD )
		  ,Marker_nModels = (SELECT Marker_nModels from  #tempTBLCAD )
		  ,Marker_nPieces = (SELECT Marker_nPieces from  #tempTBLCAD )
		  ,Marker_PlacPieces = (SELECT Marker_PlacPieces from  #tempTBLCAD )
		  ,Marker_nSizes = (SELECT Marker_nSizes from  #tempTBLCAD )
		  ,Marker_nBundles = (SELECT Marker_nBundles from  #tempTBLCAD )
		  ,Marker_Plac_Bndl = (SELECT Marker_nBundles from  #tempTBLCAD )
		  ,Marker_Bias = (SELECT Marker_Bias from  #tempTBLCAD )
		  ,Marker_Flip = (SELECT Marker_Flip from  #tempTBLCAD )
		  ,Marker_Nap = (SELECT Marker_Nap from  #tempTBLCAD )
		  ,Marker_NCEdits = (SELECT Marker_NCEdits from  #tempTBLCAD )
		  ,Marker_Spread = (SELECT Marker_Spread from  #tempTBLCAD )
		  ,Marker_Closed = (SELECT Marker_Closed from  #tempTBLCAD )
		  ,Marker_DieBlk = (SELECT Marker_DieBlk from  #tempTBLCAD )
		  ,Marker_Tubular = (SELECT Marker_Tubular from  #tempTBLCAD )
		  ,Marker_StripePlaid = (SELECT Marker_StripePlaid from  #tempTBLCAD )
		  ,Marker_nStripes = (SELECT Marker_nStripes from  #tempTBLCAD )
		  ,Marker_nPlaids = (SELECT Marker_nPlaids from  #tempTBLCAD )
		  ,Marker_5_Star = (SELECT Marker_5_Star from  #tempTBLCAD )
		  ,Marker_Max_Splice = (SELECT Marker_Max_Splice from  #tempTBLCAD )
		  ,Marker_nSplices = (SELECT Marker_nSplices from  #tempTBLCAD )
		  ,Marker_XVariance = (SELECT Marker_XVariance from  #tempTBLCAD )
		  ,Marker_YVariance = (SELECT Marker_YVariance from  #tempTBLCAD )
		  ,Marker_Image_SN = (SELECT Marker_Image_SN from  #tempTBLCAD )
		  ,Marker_Image_Name = (SELECT Marker_Image_Name from  #tempTBLCAD )
		 -- ,Marker_Comments = (SELECT Marker_Comments from  #tempTBLCAD )
		  ,CADCatId = (SELECT CADCatId from  #tempTBLCAD )
		  ,Category = (SELECT Category from  #tempTBLCAD )
		  ,SubCat = (SELECT SubCat from  #tempTBLCAD )
		  ,SubCatType = (SELECT SubCatType from  #tempTBLCAD )
		  ,Class = (SELECT Class from  #tempTBLCAD )
	--      ,UserDefined1 = (SELECT UserDefined1 from  #tempTBLCAD )
	--      ,UserDefined2 = (SELECT UserDefined2 from  #tempTBLCAD )
	--      ,UserDefined3 = (SELECT UserDefined3 from  #tempTBLCAD )
	--      ,UserDefined4 = (SELECT UserDefined4 from  #tempTBLCAD )
	--      ,UserDefined5 = (SELECT UserDefined5 from  #tempTBLCAD )
		  ,PreferMetric = (SELECT PreferMetric from  #tempTBLCAD )
		  ,IsCosting = (SELECT IsCosting from  #tempTBLCAD )
		  ,IsApproved = (SELECT IsApproved from  #tempTBLCAD )
		  ,Sizes = (SELECT Sizes from  #tempTBLCAD )
		  ,EfficiencyType = (SELECT EfficiencyType from  #tempTBLCAD )
		  ,LastCADRefresh = (SELECT LastCADRefresh from  #tempTBLCAD )
		  ,PlotFileLocation = (SELECT PlotFileLocation from  #tempTBLCAD )
		  ,NotchFile = (SELECT NotchFile from  #tempTBLCAD )
		  ,AnnotationFile = (SELECT AnnotationFile from  #tempTBLCAD )
		  ,StorageType = (SELECT StorageType from  #tempTBLCAD )
		  ,mMarker_Width = (SELECT mMarker_Width from  #tempTBLCAD )
		  ,mMarker_Length = (SELECT mMarker_Length from  #tempTBLCAD )
		  ,mMarker_Total_Perim = (SELECT mMarker_Total_Perim from  #tempTBLCAD )
		  ,mMarker_Total_Area = (SELECT mMarker_Total_Area from  #tempTBLCAD )
		  ,Yield_per_Bundle = (SELECT Yield_per_Bundle from  #tempTBLCAD )
		  ,Yield_per_Dozen = (SELECT Yield_per_Dozen from  #tempTBLCAD )
		  ,mYield_per_Bundle = (SELECT mYield_per_Bundle from  #tempTBLCAD )
		  ,mYield_per_Dozen = (SELECT mYield_per_Dozen from  #tempTBLCAD )		
			
	Where pBodyMarker.Marker_Code = (@Marker_Code)
		   AND pBodyMarker.StyleID = (@StyleID) AND pBodyMarker.StyleSet = @StyleSet and IsLinked = 1
END		   
    
    --Set @RowCnt = @RowCnt + 1
    Select @RowCnt = @RowCnt + 1	

	Drop Table #tempTBLCAD
	
END

Drop Table #tempTblBody

--Update the Usage, lossfactor, pctlossfactor, TotUsage for UnLinked Marker
Declare @TotalCnt int
Declare @ULRowCnt int

SELECT @TotalCnt = COUNT(StyleID) FROM pBodyMarker where StyleID = @StyleID  AND StyleSet = @StyleSet and IsLinked = 0

if (@TotalCnt>0)
begin
	set @ULRowCnt=1
	SELECT ROW_NUMBER() OVER(ORDER BY Marker_Code DESC) AS 'rownum', * 
	into #tempULTblBody
	FROM pBodyMarker where StyleID = @StyleID AND StyleSet = @StyleSet and IsLinked = 0
	while @ULRowCnt<=@TotalCnt
		begin			
			select @Marker_Code=Marker_Code, @StyleID=StyleID, @ID=ID, 
			@pctLossFactor1=LossFactor_pct, @LossFactor1=LossFactor, @Marker_Plac_Bndl2=Marker_Plac_Bndl,
			@Length2=Marker_Length from #tempULTblBody where rownum = @ULRowCnt
			-- calculate the usage
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

			-- calculate the LossFactor when %pctLossfactor is editable.
			if (@LossFactorenabled = 'false')
				begin
					if (@Usage1<>0)
						begin
							if (@pctLossFactor1 is not null)
								begin
									if (@pctLossFactor1 > 1)
										begin
											set @LossFactor1=round(((@pctLossFactor1-1)*@Usage1),4)
										end
									else
										begin
											set @LossFactor1=0
										end
								end
							else
								begin				
									set @LossFactor1=0
								end
						end
				end

			-- calculate the %pctLossFactor when Lossfactor is editable.
			if (@LossFactorenabled = 'true')
				begin
					if (@Usage1<>0)
						begin
							if (@LossFactor1 is not null)
								begin
									if (@LossFactor1 = 0)
										begin
											set @pctLossFactor1=1						
										end
									else
										begin
											set @pctLossFactor1=round(1+(@LossFactor1/@Usage1),4)
										end
								end
							else
								begin
									set @pctLossFactor1=1				
								end
						end
				end
			

			if (@Usage1=0)
				begin
					set @pctLossFactor1=0	
					set @LossFactor1=0
				end

							
			set @TotalUsage1 = round((@Usage1+@LossFactor1),4)
			
			Update pBodyMarker SET Usage = @Usage1, LossFactor = @LossFactor1  ,
			LossFactor_pct = @pctLossFactor1 , TotalUsage = @TotalUsage1 
			Where Marker_Code = @Marker_Code 
			AND StyleID = @StyleID  AND StyleSet = @StyleSet     
							
			set @ULRowCnt=@ULRowCnt+1
			
		end
	
end

if CHARINDEX(N'MDate Desc', @strSortOrder) != 0 
	begin	
		set @SortColumn = ''				
		--select @strSortOrder as strSortOrder1	
		set @SortColumn = Replace(@strSortOrder, ' Desc', '')  
		--select @SortColumn as SortColumn
		set @strSortOrder = @SortColumn + ' ' + 'Desc'
		--select @strSortOrder as strSortOrder2
	end


if (@Imperial <> '0')
	begin
		select @Sortsql = 'SELECT ID
      ,StyleID
      ,StyleSet
	  ,BodyID
      ,Marker_Code
      ,Marker_Name
      ,Location
      ,Last_Updated
      ,IsActive
	  ,IsLinkedBF
      ,IsLinked
	  ,Round((Usage/36),4) as Usage
      ,Round((LossFactor/36),4) as LossFactor
	  ,Round(LossFactor_pct,4) as LossFactor_pct
      ,Round((TotalUsage/36),4) as TotalUsage
	  ,Round((AdjustedUsage/36),4) as AdjustedUsage 
	  ,CUser
      ,CDate
      ,MDate
      ,MUser
      ,IsLinked
      ,Marker_Description
      ,Marker_CrOpId
      ,Marker_Create
      ,Marker_RevOp1
      ,Marker_Rev1
      ,Marker_RevOp2
      ,Marker_Rev2
      ,Round(Marker_Width,4) as Marker_Width
      ,Round((Marker_Length/36),4) as Marker_Length
      ,Round((Marker_Total_Perim/36),4) as Marker_Total_Perim
      ,Round((Marker_Total_Area/1296),4) as Marker_Total_Area
      ,Marker_Goal
      ,Round(Marker_Efficiency,4) as Marker_Efficiency
      ,Marker_Notches
      ,Marker_Drillholes
      ,Marker_Corners
      ,Marker_Message
      ,Marker_nModels
      ,Marker_nPieces
      ,Marker_PlacPieces
      ,Marker_nSizes
      ,Marker_nBundles
      ,Marker_Plac_Bndl
      ,Marker_Bias
      ,Marker_Flip
      ,Marker_Nap
      ,Marker_NCEdits
      ,Marker_Spread
      ,Marker_Closed
      ,Marker_DieBlk
      ,Marker_Tubular
      ,Marker_StripePlaid
      ,Marker_nStripes
      ,Marker_nPlaids
      ,Marker_5_Star
      ,Marker_Max_Splice
      ,Marker_nSplices
      ,Marker_XVariance
      ,Marker_YVariance
      ,Marker_Image_SN
      ,Marker_Image_Name
      ,convert (nvarchar(300),Marker_Comments) as Marker_Comments
      ,CADCatId
      ,Category
      ,SubCat
      ,SubCatType
      ,Class
      ,UserDefined1
      ,UserDefined2
      ,UserDefined3
      ,UserDefined4
      ,UserDefined5
      ,PreferMetric
      ,IsCosting
      ,IsApproved
      ,Sizes
      ,EfficiencyType
      ,LastCADRefresh
      ,PlotFileLocation
      ,NotchFile
      ,AnnotationFile
      ,StorageType
      ,mMarker_Width
      ,mMarker_Length
      ,mMarker_Total_Perim
      ,mMarker_Total_Area
      ,Yield_per_Bundle
      ,Yield_per_Dozen
      ,mYield_per_Bundle
      ,mYield_per_Dozen 
	  ,IsForAveraging FROM pBodyMarker  WHERE (StyleID = ' + CHAR(39) + Convert(nvarchar(50),@StyleID) + CHAR(39) + ' AND StyleSet =' + Convert(nvarchar(4),@StyleSet) +' and IsActive = 1)' 	  	  
	  + ' order by ' + convert(nvarchar(50),@strSortOrder)
		
		--select @Sortsql as Sortsql		
		--EXECUTE sp_executesql @Sortsql		
	end
else
		begin
			select @Sortsql = 'SELECT ID
		  ,StyleID
		  ,StyleSet
		  ,BodyID
		  ,Marker_Code
		  ,Marker_Name
		  ,Location
		  ,Last_Updated
		  ,IsActive
		  ,IsLinkedBF
		  ,IsLinked
		  ,Round((Usage/36)*0.9144,4) as Usage
		  ,Round((LossFactor/36)*0.9144,4) as LossFactor
		  ,Round(LossFactor_pct,4) as LossFactor_pct
		  ,Round((TotalUsage/36)*0.9144,4) as TotalUsage
		  ,Round((AdjustedUsage/36)*0.9144,4) as AdjustedUsage
		  ,CUser
		  ,CDate
		  ,MDate
		  ,MUser
		  ,IsLinked
		  ,Marker_Description
		  ,Marker_CrOpId
		  ,Marker_Create
		  ,Marker_RevOp1
		  ,Marker_Rev1
		  ,Marker_RevOp2
		  ,Marker_Rev2
		  ,Round(Marker_Width*2.54,4) as Marker_Width
		  ,Round((Marker_Length/36)*0.9144,4) as Marker_Length
		  ,Round((Marker_Total_Perim/36)*0.9144,4) as Marker_Total_Perim
		  ,Round((Marker_Total_Area/1296)*0.8361,4) as Marker_Total_Area
		  ,Marker_Goal
		  ,Round(Marker_Efficiency,4) as Marker_Efficiency
		  ,Marker_Notches
		  ,Marker_Drillholes
		  ,Marker_Corners
		  ,Marker_Message
		  ,Marker_nModels
		  ,Marker_nPieces
		  ,Marker_PlacPieces
		  ,Marker_nSizes
		  ,Marker_nBundles
		  ,Marker_Plac_Bndl
		  ,Marker_Bias
		  ,Marker_Flip
		  ,Marker_Nap
		  ,Marker_NCEdits
		  ,Marker_Spread
		  ,Marker_Closed
		  ,Marker_DieBlk
		  ,Marker_Tubular
		  ,Marker_StripePlaid
		  ,Marker_nStripes
		  ,Marker_nPlaids
		  ,Marker_5_Star
		  ,Marker_Max_Splice
		  ,Marker_nSplices
		  ,Marker_XVariance
		  ,Marker_YVariance
		  ,Marker_Image_SN
		  ,Marker_Image_Name
		  ,convert (varchar(300),Marker_Comments) as Marker_Comments
		  ,CADCatId
		  ,Category
		  ,SubCat
		  ,SubCatType
		  ,Class
		  ,UserDefined1
		  ,UserDefined2
		  ,UserDefined3
		  ,UserDefined4
		  ,UserDefined5
		  ,PreferMetric
		  ,IsCosting
		  ,IsApproved
		  ,Sizes
		  ,EfficiencyType
		  ,LastCADRefresh
		  ,PlotFileLocation
		  ,NotchFile
		  ,AnnotationFile
		  ,StorageType
		  ,mMarker_Width
		  ,mMarker_Length
		  ,mMarker_Total_Perim
		  ,mMarker_Total_Area
		  ,Yield_per_Bundle
		  ,Yield_per_Dozen
		  ,mYield_per_Bundle
		  ,mYield_per_Dozen 
		  ,IsForAveraging FROM pBodyMarker  WHERE (StyleID = ' + CHAR(39) + Convert(nvarchar(50),@StyleID) + CHAR(39) + ' AND StyleSet = ' + Convert(nvarchar(4),@StyleSet) + ' and IsActive = 1)' 		  	  
		  + ' order by ' + convert(nvarchar(50),@strSortOrder) 
		  
		  --select @Sortsql as Sortsql
		  --EXECUTE sp_executesql @Sortsql
		 EXECUTE(@Sortsql)
	end
	GO
	
	IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02253'))
	BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02253', GetDate())
	END	
	GO


