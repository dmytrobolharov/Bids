IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pYearCalendar_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pYearCalendar_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pYearCalendar_SELECT](
@TradePartnerId uniqueidentifier
)
as 

Declare @IncrCols nvarchar(2000)
Declare @iMonthCnt int
Declare @RowCnt int
Declare @iYearStart int
DECLARE @query NVARCHAR(max)
set @RowCnt=1
set @IncrCols = ''
set @iMonthCnt = 12
WHILE @RowCnt <= @iMonthCnt
	begin
		set @IncrCols = @IncrCols + 'YearMonth' + convert(nvarchar(3), @RowCnt) + ','		
		set @RowCnt = @RowCnt + 1
	end	
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)		
	
SET @query = N'select YearCalendarID, MonthNo, MonthSel
	from 
		(select YearCalendarID, ' + @IncrCols + ' from pyearcalendar
		) p
	unpivot
	(MonthSel For MonthNo in (' + @IncrCols + ')) as unpvt;'

CREATE TABLE #tempYearSel (
			  CalendarRowid int NOT NULL IDENTITY (1, 1)				 
			 ,YearCalendarID UNIQUEIDENTIFIER	
			 ,MonthNo nvarchar(50)
			 ,MonthSel int			 
			 )
			 
 INSERT #tempYearSel EXEC (@query) 
 
 select  top 1 CalendarRowid  from #tempYearSel where MonthSel=1	
  
 drop TABLE #tempYearSel
 
 Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03299'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03299', GetDate())

END
GO 