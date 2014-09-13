
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_SyncWithHeader]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_SyncWithHeader]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeas_SyncWithHeader]
(
	@StyleID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleSet int,	
	@AMLMeasHdrId uniqueidentifier,		
	@CDate datetime,
	@CUser  nvarchar(200) 
)

AS

begin

Declare @MaxSizeCnt int
Declare @Maxcount int
DECLARE @SizeRangeCode nvarchar(50)
Declare @RowCnt int
Declare @IncrCols nvarchar(2000)
DECLARE @query NVARCHAR(max)

--set @WorkflowItemID ='b065da5f-ef87-4e8a-9733-d9744986b0e4'
--set @WorkflowID ='40000000-0000-0000-0000-000000000050'
--set @StyleSet=1
--set @StyleID = '6296765c-a7c6-48c2-a937-fee099e5596e'
--set @AMLMeasHdrId='D4381503-BB5E-4F99-B2FF-0260AFF825F8'

set @MaxSizeCnt=0
set @Maxcount=49
set @RowCnt = 0
set @IncrCols = ''

select @SizeRangeCode=SizeRange from pstyleheader where StyleID = @StyleID and StyleSet = @StyleSet

CREATE TABLE #tempSizeRange (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,SizeRangeId UNIQUEIDENTIFIER	
			 ,SizeRange nvarchar(50)			 			 
			 ,sizeid nvarchar(10)
			 ,sizename nvarchar(10)				 
			 )	
			 
WHILE @RowCnt <= @Maxcount
begin
	set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @RowCnt) + ','				
	set @RowCnt = @RowCnt + 1
end	

if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)	
	
			 
SET @query = N'select SizeRangeId, SizeRange, sizeid, sizename
from 
	(select CustomId as SizeRangeId, SizeRangeCode as SizeRange,  ' + @IncrCols + ' from pSizeRange
	 where SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
unpivot
(sizename For sizeid in (' + @IncrCols + ')) as unpvt where sizename is not null and sizename <> '''';'		

INSERT #tempSizeRange EXEC (@query) 
--select * from #tempSizeRange

update pamlmeaslbl set 	pamlmeaslbl.isvisible=1 where measlbl in (select sizename from #tempSizeRange)
update pamlmeaslbl set 	pamlmeaslbl.isvisible=0 where measlbl not in (select sizename from #tempSizeRange)
update pamlmeaslbl set 	isvisible=1 where issample=1

drop table #tempSizeRange

end

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03233'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03233', GetDate())

END

GO 