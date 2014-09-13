/****** Object:  StoredProcedure [dbo].[spx_StyleMeasChangeProduct_Update]    Script Date: 10/28/2010 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleMeasRefreshExistingPOM](	
	@AMLMeasHdrId uniqueidentifier,	
	@CUser nvarchar(200),
	@CDate datetime 
)

AS

DECLARE @CompanyID uniqueidentifier
DECLARE @ProductTypeID uniqueidentifier 
DECLARE @SizeClassID uniqueidentifier
DECLARE	@SizeRangeID uniqueidentifier
DECLARE	@SampleSizeID uniqueidentifier
declare @SampleCol int
declare @MaxSizeCol int
declare @TotalCount int
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt  int
Declare @SizeCol  int
Declare @GRSampleSizeCol  int
DECLARE @query NVARCHAR(4000)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
declare @SizeColcnt int
declare @MaxPOMRow  int
declare @MaxoldPOMRow int
declare @oldRowCounter int
declare @oldSampleCol int
declare @cntZero nvarchar(2)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @ProductTypeID = ProductTypeID,
@SizeClassID = SizeClassID , @SizeRangeID = SizeRangeID  , @CompanyID = CompanyID FROM pamlmeashdr WITH (NOLOCK) 
WHERE AMLMeasHdrId = @AMLMeasHdrId

Select @oldSampleCol = SizeCount from pGRSizeRangeDetail where SizeRangeID=@SizeRangeID and [Sample]=1

set @oldSampleCol=@oldSampleCol-1

Select @SampleCol = sizecol from pamlmeaslbl where issample=1 and amlmeashdrid=@AMLMeasHdrId

SELECT @MaxPOMRow = COALESCE(max(POM_Row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

--Select @oldSampleCol as oldSampleCol
--Select @SampleCol as SampleCol
--Select @SampleSizeID as SampleSizeID
--SELECT @MaxPOMRow as MaxPOMRow

set @SizeCnt = 1
set @IncrCols = ''
set @SizeCol = 0
set @SizeColcnt = 0
set @cntZero='0'
set @IncrNullCols = '' 
set @IncrCol = ''

--Get only Incr cols for Sizecols present
if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
				set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
				set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '''' + @cntZero + ''') AS ' + @IncrCol + ','
				SET @SizeCnt = @SizeCnt + 1
			END

	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
	if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
	--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols
end


If @MaxPOMRow > 0

	begin
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
		DROP TABLE tempIGCData

		CREATE TABLE tempIGCData (
			 POMCompanyId nvarchar(50)
			 ,POMGuidId nvarchar(50)
			 ,POMAlternatesId nvarchar(50)
			 ,AMLMeasPomId nvarchar(50)		
			 ,Alternatescode nvarchar(10)
			 ,AlternatesDesc nvarchar(100)
			 ,PomDesc nvarchar(200)
			 ,Refcode nvarchar(10)
			 ,TolPlus decimal(18,4)
			 ,TolMinus decimal(18,4)	
			 ,How2MeasText nvarchar(500)
			 ,SortField int
			 ,IsOnQA int	
			 ,VideoSerialnumber int
			 ,WSRowId int
			 ,POM_Row int		 		
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)	
			
		)

		SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid, AMLMeasPomId, Alternatescode, AlternatesDesc, PomDesc,
		Refcode , TolPlus, TolMinus, How2MeasText, SortField, IsOnQA,  VideoSerialnumber, WSRowId, POM_Row,
		tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
		(SELECT v.POMCompanyId,  v. pomguidid, v.pomalternatesid, t.AMLMeasPomId, v.Alternatescode, v.AlternatesDesc, v.PomDesc, v.Refcode , 
		v.TolPlus, v.TolMinus, v.How2MeasText, v.SortField, v.IsOnQA,  v.VideoSerialnumber, t.WSRowId, t.Pom_Row, ' + @IncrNullCols + '			 
		FROM vwx_stylemeaspomdt_select v, pamlmeaspom t  where 
        (v.CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (v.SizeClassGuidId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
		(v.GarmentGuidID = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (v.SizeRangeGuidId = ''' + cast(@SizeRangeId as nvarchar(50)) + ''') AND 
		(v.POMCompanyId=t.GRPOMCompanyId) and (v.Refcode=t.Refcode) AND (t.AMLMeasHdrId = ''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''') AND
		(t.POM_Row <= ''' + cast(@MaxPOMRow as nvarchar(5)) + ''')) vwx_stylemeaspomdt_select		
		UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'

        --select @query as igcqry

		INSERT  tempIGCData EXEC (@query) 

        --select  * FROM tempIGCData order by POM_Row, sizecol

		SELECT @RowCounter = COUNT(*) FROM tempIGCData

		if @RowCounter>0	

			begin								
				
				set @SizeColcnt = @oldSampleCol+1
				set @SizeCol =	@oldSampleCol	 
               				
				--select @SizeCol, @samplecol	
				--select count(*) as igccount3 from pamlmeasigc 
				update pamlmeaspom set [Description] = (t.PomDesc + case t.Alternatescode when '' then '' else '--' + t.AlternatesDesc end) ,  Tolplus = t.Tolplus ,		
				TolMinus = (case left(t.TolMinus,1) when '-' then t.TolMinus else convert(decimal(18,4),('-' + cast(t.TolMinus as nvarchar(20)))) end)  					
				from pamlmeaspom p inner join tempIGCData t on p.GRPOMCompanyId=t.POMCompanyId 
				and p.AMLMeasPomId=t.AMLMeasPomId and p.refcode=t.refcode	where  p.amlmeashdrid=@AMLMeasHdrId  and p.pom_row <= @MaxPOMRow
				
				update pamlmeasigc set Incr =  case @IsNegative when 1 
				then
					(cast((case when (substring(cast(t.Sizecol as nvarchar(10)), 5, len(t.Sizecol)-4)  <= @SizeColcnt) then 						
						(case t.Incr
							when '' then  convert(decimal(18,4),-0)
							when 'B' then convert(decimal(18,4),0)							
							else
								(case when left(t.Incr,1) = '-' then dbo.fnx_Frac2Num(t.Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),t.Incr)) end)
						 end)
					else
						dbo.fnx_Frac2Num(t.Incr)
					end) as decimal(18,4)))
				else
					cast((case t.Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(t.Incr) end) as decimal(18,4))
				end							
				from pamlmeasigc i inner join tempIGCData t on 
				i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row and i.sizecol=convert(int,(cast(substring(cast(t.Sizecol as nvarchar(10)), 5, len(t.Sizecol)-4) as int)-1)) inner join 
				pamlmeaspom p on p.GRPOMCompanyId=t.POMCompanyId and p.refcode=t.refcode
				and p.AMLMeasPomId=t.AMLMeasPomId and p.pom_row=t.pom_row 
				where i.amlmeashdrid=@AMLMeasHdrId 
				and i.sizecol<>@samplecol and i.pom_row <= @MaxPOMRow

			end
				
end	     
  		

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
DROP TABLE tempIGCData
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCOldData') AND type in (N'U'))
DROP TABLE tempIGCOldData
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempsampleData') AND type in (N'U'))
DROP TABLE tempsampleData

if @IsRelative=1 
	begin
		EXEC spx_StyleMeasIMRelative_UPDATE	
		@AMLMeasHdrId		
	end
else
	begin
		EXEC spx_StyleMeasIMIncrement_UPDATE	
		@AMLMeasHdrId		
	end
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '628', GetDate())
GO