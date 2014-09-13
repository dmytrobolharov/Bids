-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_PGRMeasurementsPOMSampleSize_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_PGRMeasurementsPOMSampleSize_SELECT
GO


CREATE PROCEDURE spx_PGRMeasurementsPOMSampleSize_SELECT
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

CREATE TABLE #tempSampleSize (
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
 
 INSERT #tempSampleSize EXEC (@query) 
 
 select sizeRowid from #tempSampleSize where SampleSel =1
 
 drop table #tempSampleSize
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03026', GetDate())
GO

SET NOCOUNT Off
GO
