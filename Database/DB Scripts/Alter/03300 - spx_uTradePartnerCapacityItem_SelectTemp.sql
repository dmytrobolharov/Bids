IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerCapacityItem_SelectTemp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerCapacityItem_SelectTemp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_uTradePartnerCapacityItem_SelectTemp]
(
	@TradePartnerId uniqueidentifier
	,@TradePartnerCapacityID uniqueidentifier	
)

AS

Declare @IncrCols nvarchar(2000)
Declare @iMonthCnt int
Declare @RowCnt int
Declare @iYearStart int
DECLARE @query NVARCHAR(max)
set @RowCnt=1
set @IncrCols = ''
set @iMonthCnt = 12

CREATE TABLE #tempCapYearSel (
  CalendarRowid int NOT NULL IDENTITY (1, 1)  
 ,TradePartnerCapacityItemID UNIQUEIDENTIFIER 
 ,TradePartnerCapacityId nvarchar(50)			  
 ,TradePartnerProductTypeId UNIQUEIDENTIFIER 
 ,TradePartnerId UNIQUEIDENTIFIER 
 ,StyleCategoryID UNIQUEIDENTIFIER 
 ,CategoryName nvarchar(200)
 ,sort int null
 ,TradePartnerCap1 int	null
 ,TradePartnerCap2 int	null
 ,TradePartnerCap3 int	null 
 ,TradePartnerCap4 int	null
 ,TradePartnerCap5 int	null 
 ,TradePartnerCap6 int	null
 ,TradePartnerCap7 int	null
 ,TradePartnerCap8 int	null
 ,TradePartnerCap9 int	null
 ,TradePartnerCap10 int	null
 ,TradePartnerCap11 int	null
 ,TradePartnerCap12 int	null		 
 )
 
 insert into uTradePartnerCapacityItem 
 (TradePartnerCapacityItemID ,TradePartnerCapacityId , StyleCategoryID , Active)
 select NEWID() , @TradePartnerCapacityId ,  p.StyleCategoryID ,  1   from uTradePartnerProductType p
 inner join pStyleCategory c ON p.StyleCategoryId = c.StyleCategoryId where 
 p.TradePartnerId = @TradePartnerId and p.Active=1 and p.StyleCategoryID not in 
(select StyleCategoryID from uTradePartnerCapacityItem where  TradePartnerCapacityID = @TradePartnerCapacityID)

Update uTradePartnerCapacityItem set sort=t.sort from uTradePartnerCapacityItem b
inner join uTradePartnerProductType t  on b.StyleCategoryId=t.StyleCategoryId
where b.TradePartnerCapacityID=@TradePartnerCapacityID 	and t.TradePartnerId=@TradePartnerId		


 insert into #tempCapYearSel 
 (TradePartnerCapacityItemID ,TradePartnerCapacityId , TradePartnerProductTypeId ,  TradePartnerId
 ,StyleCategoryID , CategoryName, sort  ,TradePartnerCap1  ,TradePartnerCap2  ,TradePartnerCap3  ,TradePartnerCap4 
 ,TradePartnerCap5  ,TradePartnerCap6  ,TradePartnerCap7  ,TradePartnerCap8  ,TradePartnerCap9  ,TradePartnerCap10 
 ,TradePartnerCap11 ,TradePartnerCap12 )
 select u.TradePartnerCapacityItemID , u.TradePartnerCapacityId , p.TradePartnerProductTypeId,  c.TradePartnerId
 ,u.StyleCategoryID  , s.StyleCategory as CategoryName, u.sort  , TradePartnerCap1  ,TradePartnerCap2  ,TradePartnerCap3  ,TradePartnerCap4 
 ,TradePartnerCap5  ,TradePartnerCap6  ,TradePartnerCap7  ,TradePartnerCap8  ,TradePartnerCap9  ,TradePartnerCap10 
 ,TradePartnerCap11 ,TradePartnerCap12 from uTradePartnerCapacityItem u
 inner join uTradePartnerCapacity c on c.TradePartnerCapacityID = u.TradePartnerCapacityID
 inner join uTradePartnerProductType p on p.StyleCategoryId = u.StyleCategoryId
 and c.TradePartnerId=p.TradePartnerId 
 inner join pStyleCategory s ON p.StyleCategoryId = s.StyleCategoryId 
 where  u.TradePartnerCapacityID = @TradePartnerCapacityID
 and c.TradePartnerId=@TradePartnerId  
 

select * from #tempCapYearSel order by sort, CategoryName

drop table #tempCapYearSel
 
 Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03300'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03300', GetDate())

END
GO 