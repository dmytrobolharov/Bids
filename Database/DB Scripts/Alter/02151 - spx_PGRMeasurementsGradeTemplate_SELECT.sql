IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PGRMeasurementsGradeTemplate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PGRMeasurementsGradeTemplate_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_PGRMeasurementsGradeTemplate_SELECT]    Script Date: 11/14/2011 11:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_PGRMeasurementsGradeTemplate_SELECT](	
	@POMTempID uniqueidentifier
	,@POMTempGroupID uniqueidentifier
	,@CustomId uniqueidentifier
	,@SizeRangeCode nvarchar(50)
)

as

Declare @Maxcount int
Declare @RowCnt int
Declare @colCnt int
Declare @SizeCnt int
Declare @IncrCols nvarchar(2000)
Declare @GradeCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)
Declare  @GradeCol nvarchar(10)

DECLARE @query NVARCHAR(max)

set @RowCnt = 0
set @colCnt = 0
set @Maxcount=49
set @IncrCols = ''
set @GradeCols = '' 
set @IncrCol = ''
set @GradeCol =''
--set @CustomId = '898D5CAB-67F0-48A6-B28F-AB2374C6AB2E'
--set @SizeRangeCode = '0-16'

WHILE @RowCnt <= @Maxcount
	begin
		set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @RowCnt) + ','
		--set @IncrCol = 'Grade' + convert(nvarchar(3), @RowCnt)
		--set @GradeCols = @GradeCols + 'COALESCE(' + @IncrCol + ',' +  '''' + '0' + ''') AS ' + @IncrCol + ','
		set @RowCnt = @RowCnt + 1
	end
	
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)	
	
	--select @IncrCols as IncrCols

CREATE TABLE tempPOM (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,CustomId UNIQUEIDENTIFIER	
			 ,SizeRangeCode nvarchar(50)
			 ,SizeRangeKey nvarchar(5)
			 ,Active int
			 ,sizeid nvarchar(10)
			 ,sizename nvarchar(10)	
			 )
		
			
SET @query = N'select CustomId, SizeRangeCode, SizeRangeKey, Active, sizeid, sizename
	from 
		(select CustomId, SizeRangeCode, SizeRangeKey, Active, ' + @IncrCols + ' from pSizeRange
		 where CustomId = ''' + convert(nvarchar(50),@CustomId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
	unpivot
	(sizename For sizeid in (' + @IncrCols + ')) as unpvt;'

 --select @query as igcqry
 
 INSERT tempPOM EXEC (@query) 
 
 select @SizeCnt = max(sizeRowid) from tempPOM where sizename is not null and sizename <> ''
 
 drop table tempPOM
 
 WHILE @colCnt <= @SizeCnt
	begin		
		set @IncrCol = 'Incr' + convert(nvarchar(3), @colCnt)
		--set @GradeCol = 'Size' + convert(nvarchar(3), @colCnt)
		set @GradeCol = 'Incr' + convert(nvarchar(3), @colCnt)
		set @GradeCols = @GradeCols + 'COALESCE(' + @IncrCol + ',' +  '''' + '0' + ''') AS ' + @GradeCol + ','		
		set @colCnt = @colCnt + 1
	end
 
 if right(@GradeCols,1)=',' set @GradeCols=substring(@GradeCols, 1, len(@GradeCols)-1)  
 --select @GradeCols as GradeCols
 
 SET @query = N'select POMTempItemID, CopyPOMTempItemID, POMTempID, POMTempGroupID, 
 POMID, POMAlternatesID, POMCode, FitComID, Critical, IsonQA, IsLinked, How2MeasText, How2MeasName, Tolplus, Tolminus,  
 PomDesc, Alternatescode, AlternatesDesc, ' + @GradeCols + ' , Active, CDate, CUser, MDate, MUser, 
 Change, POMSort, AlternatesSort FROM  PGRMeasurementsPOMTemplateItem WITH (NOLOCK)
 WHERE POMTempID = ''' + convert(nvarchar(50),@POMTempID) + ''' ORDER BY POMSort, AlternatesSort, POMCode, AlternatesCode, PomDesc '
  
 --select @query as igcqry
 
 EXEC (@query) 
 
 Go
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02151'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02151', GetDate())
END	
GO
