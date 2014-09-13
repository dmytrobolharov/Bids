SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_PGRMeasurementsPOMSampleSize_SELECT')
   DROP PROCEDURE spx_PGRMeasurementsPOMSampleSize_SELECT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_PGRMeasurementsPOMSampleSize_SELECT](	
	@CustomId uniqueidentifier
	,@SizeRangeCode NVARCHAR(50)
)

as

Declare @Maxcount int
Declare @RowCnt int
Declare @IncrCols nvarchar(2000)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)
DECLARE @query NVARCHAR(max)
Declare @SampleSizeId int

set @RowCnt = 0
set @Maxcount=49
set @IncrCols = ''
set @IncrNullCols = '' 
set @IncrCol = ''

--set @CustomId = '898D5CAB-67F0-48A6-B28F-AB2374C6AB2E'
--set @SizeRangeCode = '0-16'

WHILE @RowCnt <= @Maxcount
	begin
		set @IncrCols = @IncrCols + 'Sel' + convert(nvarchar(3), @RowCnt) + ','
		set @IncrCol = 'Sel' + convert(nvarchar(3), @RowCnt)
		set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '''' + '0' + ''') AS ' + @IncrCol + ','
		set @RowCnt = @RowCnt + 1
	end
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
	if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
	
	--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols

CREATE TABLE tempSampleSize (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,CustomId UNIQUEIDENTIFIER	
			 ,SizeRangeCode nvarchar(50)
			 ,SizeRangeKey nvarchar(5)
			 ,Active int
			 ,Sampleid nvarchar(10)
			 ,SampleSel int	
			 )
		
			
SET @query = N'select CustomId, SizeRangeCode, SizeRangeKey, Active, Sampleid, SampleSel
	from 
		(select CustomId, SizeRangeCode, SizeRangeKey, Active, ' + @IncrCols + ' from pSizeRange
		 where CustomId = ''' + convert(nvarchar(50),@CustomId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
	unpivot
	(SampleSel For Sampleid in (' + @IncrCols + ')) as unpvt;'

 --select @query as igcqry
 
 INSERT tempSampleSize EXEC (@query) 
 
 select sizeRowid from tempSampleSize where SampleSel =1
 
 drop table tempSampleSize
 

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02102'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02102', GetDate())
	END
GO