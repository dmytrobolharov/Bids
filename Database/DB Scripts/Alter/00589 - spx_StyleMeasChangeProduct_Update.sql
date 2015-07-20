set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasChangeProduct_Update') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasChangeProduct_Update
GO


Create PROCEDURE [dbo].[spx_StyleMeasChangeProduct_Update](	
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,
	@SampleSizeID uniqueidentifier,
	@ProductTypeID uniqueidentifier,	
	@KeepExistingPOM int,
	@Keepsamplesizemeas int,
	@OverrideDesc int,
	@OverrideRules int,
	@RemoveRules int,
	@CUser nvarchar(200),
	@CDate datetime 
)

AS

DECLARE @OldProductTypeID uniqueidentifier 
declare @SampleCol int
declare @MaxSizeCol int
declare @TotalCount int
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt as int
Declare @SizeCol as int
Declare @GRSampleSizeCol as nvarchar(10)
DECLARE @query NVARCHAR(4000)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
declare @SizeColcnt as int
declare @MaxPOMRow as int
declare @MaxoldPOMRow int
declare @oldRowCounter int
declare @oldSampleCol int

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @OldProductTypeID = ProductTypeID 
FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Select @SampleCol = SizeCount from pGRSizeRangeDetail where SizeRangeID=@SizeRangeID and SizeRangeDetailId=@SampleSizeID

set @SampleCol = @SampleCol-1

Select @oldSampleCol = sizecol from pamlmeaslbl where issample=1 and amlmeashdrid=@AMLMeasHdrId

SELECT @MaxPOMRow = COALESCE(max(POM_Row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

--Select @oldSampleCol as oldSampleCol
--Select @SampleCol as SampleCol
--Select @SampleSizeID as SampleSizeID
--SELECT @MaxPOMRow as MaxPOMRow

set @SizeCnt = 1
set @IncrCols = ''
set @SizeCol = 0
set @SizeColcnt = 0

--Get only Incr cols for Sizecols present
if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
				SET @SizeCnt = @SizeCnt + 1
			END

	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
	--select @IncrCols
end

If @KeepExistingPOM = 0
	begin
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
		DROP TABLE tempIGCData

		CREATE TABLE tempIGCData (
			 POMCompanyId nvarchar(50)
			 ,POMGuidId nvarchar(50)
			 ,POMAlternatesId nvarchar(50)	
			 ,Alternatescode nvarchar(10)
			 ,AlternatesDesc nvarchar(100)
			 ,PomDesc nvarchar(200)
			 ,Refcode nvarchar(10)		
			 ,POM_Row int		 		
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)				
		)

		SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Alternatescode, AlternatesDesc, PomDesc, Refcode , POM_Row, tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
		(SELECT v.POMCompanyId,  v. pomguidid, v.pomalternatesid, v.Alternatescode, v.AlternatesDesc, v.PomDesc, v.Refcode , t.Pom_Row, ' + @IncrCols + '			 
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

        --hold existing data in the meas buubble
        IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCOldData') AND type in (N'U'))
		DROP TABLE tempIGCOldData

		CREATE TABLE tempIGCOldData (
			 POMCompanyId nvarchar(50)
			 ,POMGuidId nvarchar(50)
			 ,POMAlternatesId nvarchar(50)	
			 ,AMLMeasPomId nvarchar(50)			 
			 ,Refcode nvarchar(10)	
			 ,PomDesc nvarchar(200)				 		
			 ,Sizecol nvarchar(10)	
			 ,POM_Row int
			 ,WSRowid int
			 ,Incr nvarchar(20)				
		)
		--select count(*) from tempIGCData
        --hold sample data  for old sample
        IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempsampleData') AND type in (N'U'))
		DROP TABLE tempsampleData

		CREATE TABLE tempsampleData (
			 POMCompanyId nvarchar(50)
			 ,POMGuidId nvarchar(50)
			 ,POMAlternatesId nvarchar(50)	
			 ,AMLMeasPomId nvarchar(50)
			 ,AMLMeasIGCId nvarchar(50)		 
			 ,Refcode nvarchar(10)				 			 		
			 ,Sizecol nvarchar(10)	
			 ,POM_Row int
			 ,WSRowid int
			 ,Incr nvarchar(20)				
		)
		
		if @RemoveRules=1
			begin
				update pamlmeasigc set Incr = 0 from pamlmeasigc i inner join pamlmeaspom m on
				i.amlmeashdrid = m.amlmeashdrid and i.AMLMeasPomId=m.AMLMeasPomId and i.pom_row=m.pom_row								
				where i.amlmeashdrid=@AMLMeasHdrId and i.pom_row <= @MaxPOMRow and 
				((m.GRPOMCompanyId is null) or
				(m.GRPOMCompanyId = cast('' as nvarchar(50))))
			end

		if @Keepsamplesizemeas=1
			begin
				if @oldSampleCol<>@SampleCol
					begin
						INSERT INTO tempsampleData(POMCompanyId, POMGuidId, POMAlternatesId, Refcode,  
						AMLMeasPomId, AMLMeasIGCId, POM_Row, WSRowid, SizeCol, Incr )
						(select p.GRPOMCompanyId, p.POMGuidId, p.POMAlternatesId, p.Refcode, 										
						p.AMLMeasPomId, i.AMLMeasIGCId, p.POM_Row, p.WSRowid, Sizecol , Grade										
						from pamlMeaspom p, pamlMeasigc i where p.pom_row=i.pom_row and
						p.AMLMeasPomId=i.AMLMeasPomId and p.amlmeashdrid=i.amlmeashdrid
						and p.POM_Row <= @MaxPOMRow and i.sizecol=@oldSampleCol and p.amlmeashdrid=@AMLMeasHdrId ) 
						
						--select * FROM tempsampleData order by pom_row , sizecol

						update pamlmeasigc set Incr = t.Incr								
						from pamlmeasigc i inner join tempsampleData t on 
						i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row										 
						where i.amlmeashdrid=@AMLMeasHdrId 
						and i.sizecol=@samplecol and i.pom_row <= @MaxPOMRow

						update pamlmeasigc set Incr = 0								
						from pamlmeasigc i inner join tempsampleData t on 
						i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row										 
						where i.amlmeashdrid=@AMLMeasHdrId and ((t.POMCompanyId is null) or
						(t.POMCompanyId = cast('' as nvarchar(50)))) and i.sizecol=@oldsamplecol and i.pom_row <= @MaxPOMRow																	
					end
			end

		if @RowCounter>0	
			begin				
				set @GRSampleSizeCol = (select top 1 SizeCol from tempIGCData where Incr = 'B')			
				set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
				set @SizeColcnt = @SizeCol
				set @SizeCol =	@SizeCol-1	 
               				
				--select @SizeCol, @samplecol	
				--select count(*) as igccount3 from pamlmeasigc 

				INSERT INTO tempIGCOldData(POMCompanyId, POMGuidId, POMAlternatesId, Refcode, PomDesc, 
				AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr )
				(select t.POMCompanyId, t.POMGuidId, t.POMAlternatesId, t.Refcode, 
				PomDesc = PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end ,
				p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,
				Incr =  case @IsNegative when 1 
				then
					(cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 						
						(case Incr
							when '' then  convert(decimal(18,4),-0)
							when 'B' then convert(decimal(18,4),0)							
							else
								(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
						 end)
					else
						dbo.fnx_Frac2Num(Incr)
					end) as decimal(18,4)))
				else
					cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))
				end			
				--cast((case Incr when 'B' then convert(decimal(18,4),0) else ( (case Incr when '' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,								
				from pamlMeaspom p, tempIGCData t where p.GRPOMCompanyId=t.POMCompanyId and p.pomguidid=t.pomguidid
				and p.pomalternatesid=t.pomalternatesid and p.refcode=t.refcode and p.POM_Row <= @MaxPOMRow and p.amlmeashdrid=@AMLMeasHdrId ) 
								
				SELECT @oldRowCounter = COUNT(*) FROM tempIGCOldData

				--select * FROM tempIGCOldData order by pom_row , sizecol
                --SELECT @oldRowCounter as oldRowCounter
 
				if @oldRowCounter>0
					begin
						if @OverrideDesc=1 
							begin
								update pamlmeaspom set Description = t.PomDesc						
								from pamlmeaspom p inner join tempIGCOldData t on p.GRPOMCompanyId=t.POMCompanyId 
								and p.refcode=t.refcode	where  p.amlmeashdrid=@AMLMeasHdrId  and p.pom_row <= @MaxPOMRow											
							end						

						if @Keepsamplesizemeas=0
							begin
								update pamlmeasigc set Incr = 0 from pamlmeasigc i inner join tempIGCOldData t on 
								i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row inner join 
								pamlmeaspom p on p.GRPOMCompanyId=t.POMCompanyId and p.refcode=t.refcode
								and p.AMLMeasPomId=t.AMLMeasPomId and p.pom_row=t.pom_row 
								where i.amlmeashdrid=@AMLMeasHdrId								 
								and i.sizecol=@samplecol and i.pom_row <= @MaxPOMRow
							end
						
						if @OverrideRules=1
							begin
								update pamlmeasigc set Incr =  t.Incr								
								from pamlmeasigc i inner join tempIGCOldData t on 
								i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row inner join 
								pamlmeaspom p on p.GRPOMCompanyId=t.POMCompanyId and p.refcode=t.refcode
								and p.AMLMeasPomId=t.AMLMeasPomId and p.pom_row=t.pom_row 
								where i.amlmeashdrid=@AMLMeasHdrId 
								and i.sizecol<>@samplecol and i.pom_row <= @MaxPOMRow
							end	
							--select * FROM pamlmeasigc order by pom_row , sizecol
					end				
	end		
end	     
  		
if @OldSampleCol<>@SampleCol
	begin
		Update pamlmeaslbl set IsSample=0 where AMLMeasHdrId = @AMLMeasHdrId and IsSample=1			
		Update pamlmeaslbl set IsSample=1 where AMLMeasHdrId = @AMLMeasHdrId and sizecol = @SampleCol
	end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
DROP TABLE tempIGCData
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCOldData') AND type in (N'U'))
DROP TABLE tempIGCOldData
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempsampleData') AND type in (N'U'))
DROP TABLE tempsampleData

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '589', GetDate())
GO

