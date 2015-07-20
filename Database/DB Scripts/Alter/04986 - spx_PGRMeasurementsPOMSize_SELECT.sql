/****** Object:  StoredProcedure [dbo].[spx_PGRMeasurementsPOMSize_SELECT]    Script Date: 02/06/2013 14:41:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PGRMeasurementsPOMSize_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PGRMeasurementsPOMSize_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_PGRMeasurementsPOMSize_SELECT]    Script Date: 02/06/2013 14:41:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_PGRMeasurementsPOMSize_SELECT]
(
	@CustomId uniqueidentifier
	,@SizeRangeCode NVARCHAR(50)
)
AS

Declare @Maxcount int
Declare @RowCnt int
Declare @IncrCols nvarchar(2000)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)
Declare @GradeCols nvarchar(2000)
Declare  @GradeCol nvarchar(10)
DECLARE @query NVARCHAR(max)

set @RowCnt = 0
set @Maxcount=49
set @IncrCols = ''
set @IncrNullCols = '' 
set @IncrCol = ''
set @GradeCols = '' 
set @GradeCol =''


--set @CustomId = '898D5CAB-67F0-48A6-B28F-AB2374C6AB2E'
--set @SizeRangeCode = '0-16'
WHILE @RowCnt <= @Maxcount
	begin
		set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @RowCnt) + ','
		set @IncrCol = 'Size' + convert(nvarchar(3), @RowCnt)
		set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '''' + '0' + ''') AS ' + @IncrCol + ','		
		set @RowCnt = @RowCnt + 1
	end			
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
	if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)	
	--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols

CREATE TABLE #tempPOM (
			 sizeRowid int NOT NULL IDENTITY (0, 1) 
			 ,CustomId UNIQUEIDENTIFIER	
			 ,SizeRangeCode nvarchar(50) COLLATE database_default
			 ,SizeRangeKey nvarchar(5) COLLATE database_default
			 ,Active int
			 ,sizeid nvarchar(10) COLLATE database_default
			 ,sizename nvarchar(10)	 COLLATE database_default
			 ,sizeDesc nvarchar(200)  COLLATE database_default
			 )
		
			
SET @query = N'select CustomId, SizeRangeCode, SizeRangeKey, Active, sizeid, sizename
	from 
		(select CustomId, SizeRangeCode, SizeRangeKey, Active, ' + @IncrCols + ' from pSizeRange
		 where CustomId = ''' + convert(nvarchar(50),@CustomId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
	unpivot
	(sizename For sizeid in (' + @IncrCols + ')) as unpvt;'

 --select @query as igcqry
 
 INSERT #tempPOM (CustomId, SizeRangeCode, SizeRangeKey, Active, sizeid, sizename) EXEC (@query) 


-- get size descriptions from pSizeRange (SizeDesc1, SizeDesc2, SizeDesc3...)
SET @query = 
N'UPDATE #tempPOM
SET sizeDesc = pSizeRangeDesc.sizename
	FROM 
	(
		select SizeRangeId, SizeRange, REPLACE(sizeid,''Desc'','''') as sizeid, sizename
		from
		(select CustomId as SizeRangeId, SizeRangeCode as SizeRange, ' + REPLACE(@IncrCols,'Size','SizeDesc') + ' from pSizeRange
			 where CustomId = ''' + convert(nvarchar(50),@CustomId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
		unpivot
		(sizename For sizeid in (' + REPLACE(@IncrCols,'Size','SizeDesc') + ')) as unpvt 
	) as pSizeRangeDesc
WHERE #tempPOM.sizeid = pSizeRangeDesc.sizeid'

EXEC(@query)

 
 select * from #tempPOM where sizename is not null and sizename <> ''
 
 drop table #tempPOM


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04986', GetDate())

GO
