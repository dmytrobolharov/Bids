IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasAccumark_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMeasAccumark_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasAccumark_INSERT]    Script Date: 03/14/2011 13:47:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleMeasAccumark_INSERT]

(	@AMLMeasHdrId uniqueidentifier,
	@POMCodeDefault nvarchar(10),    
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
Declare @SizeCnt  int
Declare @SizeCol  int
Declare @samplecol  int
Declare @GRSampleSizeCol nvarchar(10)
DECLARE @query NVARCHAR(4000)
declare @cntZero nvarchar(2)
Declare @IncrNullCols nvarchar(2000)
Declare @POMRows nvarchar(2000)
Declare @IncrCol nvarchar(10)
Declare @intPomCount int
Declare @IsAccMetric int
Declare @TotalCount int			

SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxWSRowId = COALESCE(max(WSRowid),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @CompanyId = CompanyId, @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId, 
@GarmentID = ProductTypeId, @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric 
FROM pamlmeasHdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @samplecol = sizecol from pamlmeaslbl where AMLMeasHdrId = @AMLMeasHdrId and IsSample=1

select @RowCounter = max(pomrow) from pAccumarkMeasurement where amlmeashdrid = @AMLMeasHdrId 

SET @IsAccMetric = (select  top 1 IsMetric as IsAccMetric from pAccumarkMeasurement where amlmeashdrid = @AMLMeasHdrId)

if @RowCounter>0
begin
	CREATE TABLE #tempPOMData ( 
	 TableRow int NOT NULL IDENTITY (1, 1),	 
	 pomrow int,
	 origRow int,
	 WSRowid int,	
	 Refcode nvarchar(100), 
	 pomdesc nvarchar(204)  
	 )

	--'F02CC155-D9A1-4146-ACFD-6C9CD47B774C'
	--insert into #tempPOMData (select distinct(sizecol), sizedesc from pAccumarkMeasurement where amlmeashdrid = @AMLMeasHdrId)
	insert into #tempPOMData(origRow, pomdesc)
	(select distinct(pomrow) as pomrow, pomdescription from pAccumarkMeasurement where amlmeashdrid = @AMLMeasHdrId )
    
	--Select * from #tempPOMData order by pomrow

	update #tempPOMData set pomrow =  TableRow + @MaxPOMRow, 
	Refcode = @POMCodeDefault, WSRowid =  TableRow + @MaxWSRowId
	where pomdesc Not in (select [Description] from pamlmeaspom where 
	AMLMeasHdrId=@AMLMeasHdrId)		
	
	
	update #tempPOMData set #tempPOMData.pomrow =  pamlmeaspom.POM_Row, 
	#tempPOMData.Refcode =  pamlmeaspom.Refcode,
	#tempPOMData.WSRowid =  pamlmeaspom.WSRowId
	FROM  #tempPOMData INNER JOIN pamlmeaspom ON 
	#tempPOMData.pomdesc = pamlmeaspom.[Description] AND pamlmeaspom.AMLMeasHdrId=@AMLMeasHdrId
	
	--select * from #tempPOMData
	
		
	INSERT INTO pamlmeaspom(AMLMeasHdrId, POM_Row, Refcode, [Description], WSRowid ,
	CUser, CDate, MUser, MDate)
	SELECT @AMLMeasHdrId, t.pomrow, t.Refcode, t.pomdesc, t.WSRowid, @CUser, @CDate, @CUser, @CDate 
	FROM  #tempPOMData as t where pomdesc Not in (select [Description] from pamlmeaspom where 
	AMLMeasHdrId=@AMLMeasHdrId)
	
	--Select * from pamlmeaspom where AMLMeasHdrId=@AMLMeasHdrId and POM_Row>@MaxPOMRow order by pom_row 

	INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, CUser, CDate,
	MUser, MDate)
	(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid, l.SizeCol, @CUser, @CDate, @CUser, @CDate
	from pamlmeaspom p, pamlmeaslbl l where p.AMLMeasHdrId=l.AMLMeasHdrId and p.AMLMeasHdrId=@AMLMeasHdrId
	and p.POM_Row>@MaxPOMRow and p.WSRowid>@MaxWSRowId)
	
	--Select * from pamlmeasigc where AMLMeasHdrId=@AMLMeasHdrId and POM_Row>@MaxPOMRow order by pom_row , sizecol

	CREATE TABLE #tempIGCData ( 
	 TableRow int NOT NULL IDENTITY (1, 1),	 
	 pomrow int,	
	 origRow int, 	 
	 WSRowid int,
	 amlmeaspomid	uniqueidentifier,
	 Refcode nvarchar(100), 
	 pomdesc nvarchar(204),
	 TextSizeCol nvarchar(10),
	 SizeCol nvarchar(10),
	 SizeDesc nvarchar(10), 
	 Grade numeric(18,4)	
	 )
	
	insert into #tempIGCData(pomrow, origRow, WSRowid, amlmeaspomid, Refcode, pomdesc, TextSizeCol, SizeCol, SizeDesc, Grade)
	(select t.pomrow , a.pomrow,  t.WSRowid, p.amlmeaspomid, t.Refcode, t.pomdesc, m.TextSizeCol, m.Sizecol, a.SizeDesc, a.Grade 
	from pAccumarkMeasurement a, pAccumarkMeasMap m, #tempPOMData t , pamlmeaspom p where a.amlmeashdrid = @AMLMeasHdrId  and 
	t.origRow=a.pomrow and a.amlmeashdrid=p.amlmeashdrid and t.pomrow=p.pom_row and t.WSRowid=p.WSRowid
    and t.Refcode=p.Refcode and t.pomdesc=p.[Description] 
    and a.amlmeashdrid=m.amlmeashdrid and m.TextSizeCol = a.SizeCol and m.TextSizeCol <> '')

	--Select * from #tempIGCData order by pomrow , sizecol    
	
	
	
	
	/*-- check page Method 
	if @IsAccMetric=1
		begin
			if @IsMetric=1
				begin
					Update pamlmeasigc  set pamlmeasigc.Incr=#tempIGCData.Grade 
					FROM  pamlmeasigc  INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and 	pamlmeasigc.pom_row=#tempIGCData.pomrow and 	
					pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId and  pamlmeasigc.sizecol=@samplecol

					Update pamlmeasigc  set pamlmeasigc.Grade=#tempIGCData.Grade , pamlmeasigc.ConvGrade=(#tempIGCData.Grade/(2.54))
					FROM  pamlmeasigc INNER JOIN #tempIGCData  ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and 
					pamlmeasigc.sizecol=#tempIGCData.sizecol  where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end
			else
				begin
					Update pamlmeasigc  set pamlmeasigc.Incr=(#tempIGCData.Grade/(2.54)) 
					FROM  pamlmeasigc INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and 
					pamlmeasigc.sizecol=#tempIGCData.sizecol where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
					and  pamlmeasigc.sizecol=@samplecol

					Update pamlmeasigc  set pamlmeasigc.Grade=(#tempIGCData.Grade/(2.54)) , pamlmeasigc.ConvGrade=#tempIGCData.Grade
					FROM  pamlmeasigc INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND pamlmeasigc.wsrowid = #tempIGCData.wsrowid 
					and pamlmeasigc.pom_row=#tempIGCData.pomrow and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end
		end
    else
		begin
			if @IsMetric<>1
				begin
					Update pamlmeasigc  set pamlmeasigc.Incr=#tempIGCData.Grade 
					FROM  pamlmeasigc INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and 
					pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId and  pamlmeasigc.sizecol=@samplecol

					Update pamlmeasigc  set pamlmeasigc.Grade=#tempIGCData.Grade , pamlmeasigc.ConvGrade=(#tempIGCData.Grade*2.54)
					FROM  pamlmeasigc INNER JOIN #tempIGCData  ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow 
					and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end
			else
				begin
					Update pamlmeasigc  set pamlmeasigc.Incr=(#tempIGCData.Grade*2.54)
					FROM  pamlmeasigc INNER JOIN #tempIGCData  ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow 
					and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId and  pamlmeasigc.sizecol=@samplecol

					Update pamlmeasigc  set pamlmeasigc.Grade=(t.Grade*2.54) , pamlmeasigc.ConvGrade=#tempIGCData.Grade
					FROM  pamlmeasigc INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end
		end
	
	*/

    --Only check IsMetric for Accumark import

	Update pamlmeasigc  set pamlmeasigc.Incr=#tempIGCData.Grade 
	FROM  pamlmeasigc  INNER JOIN #tempIGCData ON  
	pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
	pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and 
	pamlmeasigc.sizecol=#tempIGCData.sizecol  
	where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId and  pamlmeasigc.sizecol=@samplecol
	

    if @IsAccMetric=1
		begin						
            if @IsMetric=1
				begin
					Update pamlmeasigc  set pamlmeasigc.Grade=#tempIGCData.Grade , pamlmeasigc.ConvGrade=(#tempIGCData.Grade/(2.54))
					FROM  pamlmeasigc  INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end
			else
				begin
					Update pamlmeasigc  set pamlmeasigc.Grade=#tempIGCData.Grade , pamlmeasigc.ConvGrade=(#tempIGCData.Grade*2.54)
					FROM  pamlmeasigc  INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end			

			SELECT @TotalCount = @@rowcount 

		end
    else
		begin
			if @IsMetric<>1
				begin
					Update pamlmeasigc  set pamlmeasigc.Grade=#tempIGCData.Grade , pamlmeasigc.ConvGrade=(#tempIGCData.Grade*2.54)
					FROM  pamlmeasigc  INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end
			else
				begin
					Update pamlmeasigc  set pamlmeasigc.Grade=#tempIGCData.Grade , pamlmeasigc.ConvGrade=(#tempIGCData.Grade/(2.54))
					FROM  pamlmeasigc  INNER JOIN #tempIGCData ON  
					pamlmeasigc.amlmeaspomid = #tempIGCData.amlmeaspomid AND 	
					pamlmeasigc.wsrowid = #tempIGCData.wsrowid and pamlmeasigc.pom_row=#tempIGCData.pomrow and pamlmeasigc.sizecol=#tempIGCData.sizecol  
					where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId 
				end

			SELECT @TotalCount = @@rowcount

		end
     
 
	--Select * from pamlmeasigc where  AMLMeasHdrId=@AMLMeasHdrId and pom_row>@MaxPOMRow order by pom_row , sizecol 
	
	
	SELECT @POMRows = COALESCE(@POMRows + ',', '') + cast(pomrow as nvarchar(20))
	FROM #tempPOMData order by pomrow   
	     
    --SELECT POMRows = @POMRows
    --SELECT lPOMRows = len(@POMRows)
    
     drop table #tempPOMData
	 drop table #tempIGCData
    
	 if @TotalCount>0
		begin 
			 If @IsRelative = 1
				begin
					EXEC spx_StyleMeasADSampleSizeRelative_Update
					@AMLMeasHdrId,
					@samplecol,
					@POMRows
				end
			 else
				begin
					EXEC spx_StyleMeasADSampleSizeIncrement_Update
					@AMLMeasHdrId,
					@samplecol,
					@POMRows
				end
		end

end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01278', GetDate())
GO