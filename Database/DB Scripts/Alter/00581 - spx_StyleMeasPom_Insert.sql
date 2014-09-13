set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasPom_Insert') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasPom_Insert
GO

Create PROCEDURE [dbo].[spx_StyleMeasPom_Insert](	
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,	
	@ProductTypeID uniqueidentifier,	
	@samplecol int,
	@CUser nvarchar(200),
	@CDate datetime 
)

AS 

DECLARE @AMLMeasPomId uniqueidentifier 
Declare @Refcode nvarchar(10)
declare @Maxcount int
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

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
--drop table tempIGCData
--drop table temp_measpoms

--drop table temp_measpoms
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'temp_measpoms') AND type in (N'U'))
DROP TABLE temp_measpoms

/*Create temp table.	*/
/************************/
CREATE TABLE temp_measpoms
	(
	TableRow int NOT NULL IDENTITY (1, 1)	
	,POMCompanyId UNIQUEIDENTIFIER
	,POMGuidId UNIQUEIDENTIFIER
	,POMAlternatesId UNIQUEIDENTIFIER	
	,Refcode nvarchar(10)
	,Alternatescode nvarchar(10)
	,AlternatesDesc nvarchar(100)
	,PomDesc nvarchar(200)
	,How2MeasText nvarchar(500)
	,SortField int
	,GTSortField int
	,VideoSerialnumber int
	,TolPlus decimal(18,4)
	,TolMinus decimal(18,4)
	,IsOnQA int
	)  ON [PRIMARY]


ALTER TABLE temp_measpoms ADD CONSTRAINT
	PK_temp_measpoms PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]



select @Maxcount= count(pomcompanyid) from vwx_StyleMeasPOMDT_select  WHERE   
 (CompanyGuidID = @CompanyID) AND (SizeClassGuidId = @SizeClassID) AND 
(GarmentGuidID = @ProductTypeID) AND (SizeRangeGuidId = @SizeRangeID)

if @Maxcount>0
begin
	insert into temp_measpoms(POMCompanyId, POMGuidId, POMAlternatesId, Refcode,
	Alternatescode, AlternatesDesc, PomDesc, How2MeasText, SortField, GTSortField, VideoSerialnumber,IsOnQA, 
	TolPlus, TolMinus) 
	select POMCompanyId,POMGuidId,POMAlternatesId, Refcode, Alternatescode, AlternatesDesc, PomDesc,
	How2MeasText,SortField, GTSortField, VideoSerialnumber, IsOnQA ,
	Tolplus , TolMinus
	from vwx_StyleMeasPOMDT_select  WHERE   
	(CompanyGuidID = @CompanyID) AND (SizeClassGuidId = @SizeClassID) AND 
	(GarmentGuidID = @ProductTypeID) AND (SizeRangeGuidId = @SizeRangeID)	
end

SELECT @TotalCount = COUNT(*) FROM temp_measpoms

select count(*) from temp_measpoms


if @TotalCount>0 	
begin
	INSERT INTO pamlmeaspom(AMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, Refcode, Description, 
	 Tolplus , TolMinus, WSRowid, How2MeasText, VideoSerialnumber, Flag4QA, SortId, CUser, CDate, MUser, MDate)
	SELECT @AMLMeasHdrId , POMCompanyId , POMGuidId, POMAlternatesId, TableRow, Refcode, 	
	--PomDesc + (case Alternatescode when '' then '' else (case AlternatesDesc when '' then '' else '--' + AlternatesDesc end) end) as PomDesc, 
	(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc,  
	Tolplus ,
	(case left(TolMinus,1) when '-' then TolMinus else convert(decimal(18,4),('-' + cast(TolMinus as nvarchar(20)))) end)  as TolMinus , 
	TableRow,  How2MeasText, VideoSerialnumber, IsOnQA, SortField, @CUser, @CDate , 
	@CUser, @CDate  FROM  temp_measpoms 
end

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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
		DROP TABLE tempIGCData

		CREATE TABLE tempIGCData (
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
		(CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (SizeClassGuidId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
							  (GarmentGuidID = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (SizeRangeGuidId = ''' + cast(@SizeRangeId as nvarchar(50)) +''')
		) vwx_stylemeaspomdt_select
		UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'

		INSERT  tempIGCData EXEC (@query) 

        SELECT @RowCounter = COUNT(*) FROM tempIGCData
        
		if @RowCounter>0	
			begin

				set @GRSampleSizeCol = (select top 1 SizeCol from tempIGCData where Incr = 'B')			
				set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
				set @SizeColcnt = @SizeCol
				set @SizeCol =	@SizeCol-1			
				--select @SizeCol, @samplecol
				if @IsNegative = 1
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,
						 Incr =  
							cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 						
								(case Incr
									when '' then  convert(decimal(18,4),-0)
									when 'B' then convert(decimal(18,4),0)							
									else
										(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
								 end)
							else
								dbo.fnx_Frac2Num(Incr)
							end) as decimal(18,4)),				
						--cast((case Incr when 'B' then convert(decimal(18,4),0) else ( (case Incr when '' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,								
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, tempIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId and p.refcode=t.refcode
						)				
					end
				else
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,						
						cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, tempIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId  and p.refcode=t.refcode
						)				
					end	
			end	
		
			drop table tempIGCData
			drop table temp_measpoms
	end

Update pamlmeashdr set MeasRowCnt=@TotalCount where AMLMeasHdrId = @AMLMeasHdrId

if @SizeCol<>@samplecol
	begin		
		EXEC spx_StyleMeasIGC_Insert
		@AMLMeasHdrId,
		@samplecol,	
		@SizeCol,
		@IsNegative		
	end
		
Update pamlmeaslbl set IsSample=0 where AMLMeasHdrId = @AMLMeasHdrId and IsSample=1
Update pamlmeaslbl set IsSample=1 where AMLMeasHdrId = @AMLMeasHdrId and sizecol = @samplecol

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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'temp_measpoms') AND type in (N'U'))
DROP TABLE temp_measpoms

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
DROP TABLE tempIGCData
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '581', GetDate())
GO