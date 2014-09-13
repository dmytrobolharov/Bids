/****** Object:  StoredProcedure [dbo].[spx_StyleMeasLibrary_INSERT]    Script Date: 09/20/2010 08:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeasLibrary_INSERT]
(	@POMLibraryID uniqueidentifier,
	@AMLMeasHdrId uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime 	
)

AS 


DECLARE @MaxPomRow int 
DECLARE @MaxWSRowid	int 
DECLARE @MaxSizeCol int
DECLARE @SizeColcnt int
DECLARE @AMLMeasPomId uniqueidentifier 
DECLARE @CompanyId nvarchar(50) 
DECLARE @SizeClassId nvarchar(50)
DECLARE @SizeRangeId nvarchar(50)
DECLARE @GarmentID nvarchar(50)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
Declare @Refcode nvarchar(10)
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt as int
Declare @SizeCol as int
Declare @samplecol as int
Declare @GRSampleSizeCol as nvarchar(10)
DECLARE @query NVARCHAR(4000)


SELECT @MaxPomRow = isnull(MAX(pom_row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @CompanyId = CompanyId, @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId, 
@GarmentID = ProductTypeId, @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @MaxWSRowid = isnull(MeasRowCnt,0) 
FROM pamlmeasHdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @samplecol = sizecol from pamlmeaslbl where AMLMeasHdrId = @AMLMeasHdrId and IsSample=-1

Set @MaxPomRow=@MaxPomRow+1

Update pamlmeashdr set MeasRowCnt=@MaxWSRowid+1 where AMLMeasHdrId = @AMLMeasHdrId


INSERT INTO pamlmeaspom(AMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, Refcode, Description, TolPlus, TolMinus, 
Flag4QA, SortId, VideoSerialNumber, How2MeasText, WSRowid, CUser, CDate, 	MUser, MDate)
SELECT @AMLMeasHdrId, @POMLibraryID, POMGuidId, POMAlternatesId, @MaxPomRow, Refcode, 
(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc , 
TolPlus, 
(case left(TolMinus,1) when '-' then TolMinus else convert(decimal(18,4),('-' + cast(TolMinus as nvarchar(20)))) end)  as TolMinus ,
IsOnQA, SortField,
VideoSerialNumber, How2MeasText, @MaxWSRowid,  @CUser, @CDate , 
		@CUser, @CDate FROM  vwx_StyleMeasPOMDT_Select WITH (NOLOCK)
		WHERE (POMCompanyId = @POMLibraryID) and (CompanyGuidID = @CompanyId)
		and (SizeClassGuidId = @SizeClassId) and (SizeRangeGuidId = @SizeRangeId)
		and (GarmentGuidID = @GarmentID)


select @AMLMeasPomId = AMLMeasPomId from pamlmeaspom where AMLMeasHdrId= @AMLMeasHdrId and POM_Row=@MaxPomRow and WSRowid=@MaxWSRowid 
and GRPOMCompanyId = @POMLibraryID 

set @SizeCnt = 1
set @IncrCols = ''
set @SizeCol= 0
set @SizeColcnt=0

if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)

		--select @IncrCols
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempLibIGCData') AND type in (N'U'))
		DROP TABLE tempLibIGCData

		CREATE TABLE tempLibIGCData (
			 POMCompanyId uniqueidentifier
			 ,POMGuidId UNIQUEIDENTIFIER
			 ,POMAlternatesId UNIQUEIDENTIFIER	
			 ,Refcode nvarchar(10)			
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)				
		)

		SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Refcode , tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
		(SELECT POMCompanyId,   pomguidid, pomalternatesid, Refcode , ' + @IncrCols + '			 
		FROM vwx_stylemeaspomdt_select  where 
		(POMCompanyId = ''' + cast(@POMLibraryID	as nvarchar(50)) + ''') AND 
		(CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (SizeClassGuidId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
		(GarmentGuidID = ''' + cast(@GarmentID as nvarchar(50))+ ''') AND 
		(SizeRangeGuidId = ''' + cast(@SizeRangeId as nvarchar(50)) + ''')
		) vwx_stylemeaspomdt_select
		UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'

		INSERT  tempLibIGCData EXEC (@query) 

        SELECT @RowCounter = COUNT(*) FROM tempLibIGCData
        
		if @RowCounter>0	
			begin

				set @GRSampleSizeCol = (select top 1 SizeCol from tempLibIGCData where Incr = 'B')			
				set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
				set @SizeColcnt = @SizeCol
				set @SizeCol =	@SizeCol-1			
				--select @SizeCol, @samplecol
				if @IsNegative = -1
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxWSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,
						Incr =  
							cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 						
								(case Incr
									when '' then  convert(decimal(18,4),0)
									when 'B' then convert(decimal(18,4),0)							
									else
										(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
								 end)
							else
								dbo.fnx_Frac2Num(Incr)
							end) as decimal(18,4)),	
						--(cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 
						--cast((case Incr when 'B' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, tempLibIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.refcode=t.refcode and p.amlmeashdrid=@AMLMeasHdrId 
						and p.GRPOMCompanyId = @POMLibraryID )				
					end
				else
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxWSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,						
						cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, tempLibIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.refcode=t.refcode and p.amlmeashdrid=@AMLMeasHdrId
						and p.GRPOMCompanyId = @POMLibraryID )				
					end	
			end

        --select * from tempLibIGCData

        drop table tempLibIGCData

		if @SizeCol<>@samplecol
			begin		
				EXEC spx_StyleMeasLibraryIGC_Insert
				@AMLMeasHdrId,
				@AMLMeasPomId,
				@MaxPomRow,	
				@samplecol,	
				@SizeCol,
				@IsNegative		
			end
		
		if @IsRelative=-1 
			begin
				EXEC spx_StyleMeasPOMIMRelative_UPDATE	
				@AMLMeasHdrId,
				@AMLMeasPomId, 
				@MaxPomRow	
			end
		else
			begin
				EXEC spx_StyleMeasPOMIMIncrement_UPDATE	
				@AMLMeasHdrId,
				@AMLMeasPomId, 
				@MaxPomRow
			end


	end

return @samplecol

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '424', GetDate())
GO



