
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasChangeSizeClass_Insert]    Script Date: 11/18/2010 22:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleMeasChangeSizeClass_Insert') 
DROP PROCEDURE spx_StyleMeasChangeSizeClass_Insert
GO

Create PROCEDURE [dbo].[spx_StyleMeasChangeSizeClass_Insert](	
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,
	@SampleSizeID uniqueidentifier,
	@ProductTypeID uniqueidentifier,	
	@PrimaryKeysOnly int,		
	@KeepExistingPOM int,
	@Keepsamplesizemeas int,
	@OverrideDesc int,
	@OverrideRules int,
	@RemoveRules int,
	@CUser nvarchar(200),
	@CDate datetime 
)

AS

DECLARE @OldSizeClassID uniqueidentifier 
DECLARE @OldProductTypeID uniqueidentifier 
DECLARE @OldSizeRangeID uniqueidentifier 
DECLARE @OldSizeRange uniqueidentifier 
DECLARE @SizeRange uniqueidentifier 
declare @SampleCol int
declare @MaxSizeCol int
declare @TotalCount int
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt  int
Declare @SizeCol  int
Declare @GRSampleSizeCol as nvarchar(10)
DECLARE @query NVARCHAR(4000)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
declare @SizeColcnt  int
declare @MaxPOMRow  int
declare @MaxWSRowId int
declare @MaxRow  int
declare @MeasRowCnt int
declare @ProductType nvarchar(100)
declare @SizeRangeName nvarchar(60)
declare @SizeClassName nvarchar(60)
declare @cntZero  nvarchar(2)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @SizeRange = pGRSizeRange.SizeRangeGuidId , @SizeRangeName = pGRSizeRange.SizeRange 
FROM pGRSizeRange INNER JOIN pGRClassRange ON pGRSizeRange.SizeRangeGuidId = pGRClassRange.SizeRangeGuidId 
WHERE  (pGRClassRange.ClassRangeId = @SizeRangeID)

SELECT @MeasRowCnt = MeasRowCnt,  @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @OldProductTypeID = ProductTypeID 
,@OldSizeRangeID=SizeRangeID , @OldSizeClassID = SizeClassID FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @MaxPOMRow = COALESCE(max(POM_Row),0), @MaxWSRowId = COALESCE(max(WSRowId),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Select @SampleCol = SizeCount from pGRSizeRangeDetail where SizeRangeID=@SizeRange and SizeRangeDetailId=@SampleSizeID

set @SampleCol = @SampleCol-1

--Select @SampleCol as SampleCol
--Select @SampleSizeID as SampleSizeID

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

--add poms that only belong to new pType to temp table
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'temp_measpoms') AND type in (N'U'))
DROP TABLE temp_measpoms

CREATE TABLE temp_measpoms
	( TableRow int NOT NULL IDENTITY (1, 1)	
	,POMTempRow int		
	,POMTempWSRow int		
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
	,ImageId UNIQUEIDENTIFIER
	,TolPlus decimal(18,4)
	,TolMinus decimal(18,4)
	,IsOnQA int
	)  ON [PRIMARY]


ALTER TABLE temp_measpoms ADD CONSTRAINT
	PK_temp_measpoms PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY] 


----add poms that only belong to new pType to temp table
if @PrimaryKeysOnly=1
	begin
		insert into temp_measpoms(POMTempRow, POMTempWSRow, POMCompanyId, POMGuidId, POMAlternatesId, Refcode,
		Alternatescode, AlternatesDesc, PomDesc, How2MeasText, SortField, GTSortField, ImageId,IsOnQA, 
		TolPlus, TolMinus) 
		(SELECT  0, 0, POMCompanyId,POMGuidId,POMAlternatesId, Refcode, Alternatescode, AlternatesDesc, PomDesc,
		How2MeasText,SortField, GTSortField, ImageId, IsOnQA , Tolplus , TolMinus	
		FROM vwx_StyleMeasPOMDT_Select
		WHERE (CompanyGuidID = @CompanyID) AND (SizeClassCompanyId = @SizeClassID) AND 
		(ClassRangeId = @SizeRangeID) AND (ProductCompanyId = @ProductTypeID) AND  (IsPrimaryKeyMeas=1)) 
	end
else
	begin
		insert into temp_measpoms(POMTempRow, POMTempWSRow, POMCompanyId, POMGuidId, POMAlternatesId, Refcode,
		Alternatescode, AlternatesDesc, PomDesc, How2MeasText, SortField, GTSortField, ImageId,IsOnQA, 
		TolPlus, TolMinus) 
		(SELECT  0, 0, POMCompanyId,POMGuidId,POMAlternatesId, Refcode, Alternatescode, AlternatesDesc, PomDesc,
		How2MeasText,SortField, GTSortField, ImageId, IsOnQA , Tolplus , TolMinus	
		FROM vwx_StyleMeasPOMDT_Select
		WHERE (CompanyGuidID = @CompanyID) AND (SizeClassCompanyId = @SizeClassID) AND 
		(ClassRangeId = @SizeRangeID) AND (ProductCompanyId = @ProductTypeID))
	end

SELECT @TotalCount = max(tablerow) FROM temp_measpoms
--SELECT @TotalCount as TotalCount
If @TotalCount>0 
	begin
		update temp_measpoms set POMTempRow =  TableRow + @MaxPOMRow , POMTempWSRow =  TableRow + @MaxWSRowId 
		--add New poms for new PType and not in old PType
		INSERT INTO pamlmeaspom(AMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, Refcode, Description, 
		Tolplus , TolMinus, WSRowid, How2MeasText, ImageId, Flag4QA, SortId, CUser, CDate, MUser, MDate)
		(SELECT @AMLMeasHdrId , t.POMCompanyId , t.POMGuidId, t.POMAlternatesId, t.POMTempRow, t.Refcode, 	
		--PomDesc + (case Alternatescode when '' then '' else (case AlternatesDesc when '' then '' else '--' + AlternatesDesc end) end) as PomDesc, 
		(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc,  t.Tolplus ,		
		(case left(t.TolMinus,1) when '-' then t.TolMinus else convert(decimal(18,4),('-' + cast(t.TolMinus as nvarchar(20)))) end)  as TolMinus , 
		t.POMTempWSRow,  t.How2MeasText, t.ImageId, t.IsOnQA, t.SortField, @CUser, @CDate , 
		@CUser, @CDate  FROM  temp_measpoms t where t.POMCompanyId not in (select GRPOMCompanyId from pamlmeaspom
		where amlmeashdrid=@AMLMeasHdrId and GRPOMCompanyId is not null ))	

		--select  count(*) as tmpnewcount1 FROM temp_measpoms
		--select count(*) as pmlcount1 from pamlmeaspom        
		--select  * FROM temp_measpoms order by TableRow
		--select  * FROM pamlmeaspom order by pom_Row

		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
		DROP TABLE tempIGCData

		CREATE TABLE tempIGCData (
			 POMCompanyId uniqueidentifier
			 ,POMGuidId UNIQUEIDENTIFIER
			 ,POMAlternatesId UNIQUEIDENTIFIER	
			 ,Alternatescode nvarchar(10)
			 ,AlternatesDesc nvarchar(100)
			 ,PomDesc nvarchar(200)
			 ,Refcode nvarchar(10)	
			 ,Pom_Row int
			 ,WSRowid int			 		
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)				
		)
		if @PrimaryKeysOnly=1
			begin
				SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Alternatescode, AlternatesDesc, PomDesc, Refcode , Pom_Row, WSRowid, tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
				(SELECT v.POMCompanyId,  v. pomguidid, v.pomalternatesid, v.Alternatescode, v.AlternatesDesc, v.PomDesc, v.Refcode , t.Pom_Row, t.WSRowid, ' + @IncrNullCols + '			 
				FROM vwx_stylemeaspomdt_select v, pamlmeaspom t  where 
				(v.CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (v.SizeClassCompanyId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
				(v.ProductCompanyId = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (v.ClassRangeId = ''' + cast(@SizeRangeId as nvarchar(50)) + ''') AND 
				(v.IsPrimaryKeyMeas = 1) AND (v.POMCompanyId=t.GRPOMCompanyId) and (v.Refcode=t.Refcode) AND (t.AMLMeasHdrId = ''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''') AND
				(t.pom_row > ''' + cast(@MaxPOMRow as nvarchar(5)) + ''')) vwx_stylemeaspomdt_select		
				UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot '
			end
		else
			begin
				SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Alternatescode, AlternatesDesc, PomDesc, Refcode , Pom_Row, WSRowid, tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
				(SELECT v.POMCompanyId,  v. pomguidid, v.pomalternatesid, v.Alternatescode, v.AlternatesDesc, v.PomDesc, v.Refcode , t.Pom_Row, t.WSRowid, ' + @IncrNullCols + '			 
				FROM vwx_stylemeaspomdt_select v, pamlmeaspom t  where 
				(v.CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (v.SizeClassCompanyId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
				(v.ProductCompanyId = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (v.ClassRangeId = ''' + cast(@SizeRangeId as nvarchar(50)) + ''') AND 
				(v.POMCompanyId=t.GRPOMCompanyId) and (v.Refcode=t.Refcode) AND (t.AMLMeasHdrId = ''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''') AND
				(t.pom_row > ''' + cast(@MaxPOMRow as nvarchar(5)) + ''')) vwx_stylemeaspomdt_select		
				UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot '
			end
        --select @query as igcqry

		INSERT  tempIGCData EXEC (@query) 

        --select  * FROM tempIGCData order by pom_row, sizecol

		SELECT @RowCounter = COUNT(*) FROM tempIGCData        		

		--select count(*) as IGCData from tempIGCData
      
		if @RowCounter>0	
			begin				
				--set @GRSampleSizeCol = (select top 1 SizeCol from tempIGCData where Incr = 'B')			
				--set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
				Select @SizeCol = SizeCount from pGRSizeRangeDetail where SizeRangeID = @SizeRange and [Sample]=1				
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
								(case COALESCE(Incr,'0')
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
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.POM_Row > @MaxPOMRow 
						and p.amlmeashdrid=@AMLMeasHdrId and p.refcode=t.refcode and p.POM_Row=t.POM_Row)																
					end
				else
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,						
						cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, tempIGCData t  where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId  and p.POM_Row=t.POM_Row and p.POM_Row > @MaxPOMRow and p.refcode=t.refcode
						)							
					end	

				--select  * FROM pamlmeasigc order by pom_row, sizecol
					
			end
	
    drop table tempIGCData
	drop table temp_measpoms	
	
	--select @MaxPOMRow as maxpomrow
	--select @SizeCol as SizeCol
	--select @samplecol as samplecol
	
	if @SizeCol<>@samplecol
		begin		
			EXEC spx_StyleMeasChangeIGC_Insert
			@AMLMeasHdrId,
			@samplecol,	
			@SizeCol,
			@IsNegative,
			@MaxPOMRow		
		end	
end

SELECT @ProductType = pGRProduct.Product FROM  pGRProduct INNER JOIN
pGRProductCompany ON pGRProduct.ProductID = pGRProductCompany.ProductId
where pGRProductCompany.ProductCompanyId = @ProductTypeID

SELECT @SizeClassName = pGRSizeClass.SizeClass FROM 
pGRSizeClass INNER JOIN pGRSizeClassCompany ON pGRSizeClass.SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId 
WHERE (pGRSizeClassCompany.SizeClassCompanyId = @SizeClassID) 


Update pamlmeashdr set ProductTypeID=@ProductTypeID, SizeRangeID=@SizeRangeID , SizeClassID=@SizeClassID, ProductType=@ProductType,
SizeRange = @SizeRangeName, SizeClass = @SizeClassName , MeasRowCnt=(select max(pom_row) from pamlmeaspom where AMLMeasHdrId = @AMLMeasHdrId) 
where AMLMeasHdrId = @AMLMeasHdrId


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tempIGCData') AND type in (N'U'))
DROP TABLE tempIGCData

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'temp_measpoms') AND type in (N'U'))
DROP TABLE temp_measpoms

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
VALUES     ('DB_Version', '4.0.0000', '753', GetDate())
GO