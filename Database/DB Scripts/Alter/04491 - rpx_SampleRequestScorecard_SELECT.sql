IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestScorecard_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestScorecard_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_SampleRequestScorecard_SELECT]
AS
BEGIN

CREATE TABLE #samplesubmits
(
	StyleSeasonYearID uniqueidentifier,
	TradePartnerID uniqueidentifier, 
	TradePartnerVendorID uniqueidentifier,
	SampleRequestTradeID uniqueidentifier, 
	StyleSeason nvarchar(200),
	StyleYear nvarchar (200),
	TradePartnerCode nvarchar (200),
	TradePartnerName nvarchar (200),
	VendorCode nvarchar (200), 
	VendorName nvarchar (200),
	TradeActive nvarchar (5),
	VendorActive nvarchar (5),
	SubmitCount int,
	SubmitCountEarly int,
	SubmitCountInTime int,
	SubmitCountLate int,
	SubmitCountOther int
)

insert into #samplesubmits
select 
	sy.SeasonYearID, 
	srt.TradePartnerID, 
	srt.TradePartnerVendorID,
	srt.SampleRequestTradeID, 
	sy.Season,
	sy.[Year],
	tp.TradePartnerCode,
	tp.TradePartnerName,
	tpv.VendorCode, 
	tpv.VendorName,
	case when tp.Active = 1 then 'Yes' else 'No' end as TradeActive,
	case when tpv.Active = 1 then 'Yes' else 'No' end as VendorActive,
	COUNT(srs.SampleRequestSubmitID) as SubmitCount,
	null, null, null, null
from pSampleRequestTrade srt
 left join uTradePartner tp on srt.TradePartnerID = tp.TradePartnerID
 left join uTradePartnerVendor tpv on srt.TradePartnerVendorID = tpv.TradePartnerVendorID
 inner join pStyleSeasonYear ssy on srt.StyleSeasonYearID = ssy.StyleSeasonYearID
 inner join pSeasonYear sy on ssy.SeasonYearID = sy.SeasonYearID
 inner join pSampleRequestSubmit srs on srt.SampleRequestTradeID = srs.SampleRequestTradeID
group by 
	sy.SeasonYearID, 
	srt.TradePartnerID, 
	srt.TradePartnerVendorID,
	srt.SampleRequestTradeID, 
	sy.Season,
	sy.[Year],
	tp.TradePartnerCode,
	tp.TradePartnerName,
	tpv.VendorCode, 
	tpv.VendorName,
	tp.Active,
	tpv.Active
union
select 
	sy.SeasonYearID, 
	srt.TradePartnerID, 
	srt.TradePartnerVendorID,
	srt.SampleRequestTradeID, 
	sy.Season,
	sy.[Year],
	tp.TradePartnerCode,
	tp.TradePartnerName,
	tpv.VendorCode, 
	tpv.VendorName,
	case when tp.Active = 1 then 'Yes' else 'No' end as TradeActive,
	case when tpv.Active = 1 then 'Yes' else 'No' end as VendorActive,
	COUNT(srs.SampleRequestSubmitID) as SubmitCount,
	null, null, null, null
from pSampleRequestBOMTrade srt
 left join uTradePartner tp on srt.TradePartnerID = tp.TradePartnerID
 left join uTradePartnerVendor tpv on srt.TradePartnerVendorID = tpv.TradePartnerVendorID
 inner join pStyleSeasonYear ssy on srt.StyleSeasonYearID = ssy.StyleSeasonYearID
 inner join pSeasonYear sy on ssy.SeasonYearID = sy.SeasonYearID
 inner join pSampleRequestSubmitBOM srs on srt.SampleRequestTradeID = srs.SampleRequestTradeID
group by 
	sy.SeasonYearID, 
	srt.TradePartnerID, 
	srt.TradePartnerVendorID,
	srt.SampleRequestTradeID, 
	sy.Season,
	sy.[Year],
	tp.TradePartnerCode,
	tp.TradePartnerName,
	tpv.VendorCode, 
	tpv.VendorName,
	tp.Active,
	tpv.Active



update #samplesubmits set SubmitCountEarly = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmit WHERE DueDate > RecDate and pSampleRequestSubmit.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID)
update #samplesubmits set SubmitCountInTime = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmit WHERE DueDate = RecDate and pSampleRequestSubmit.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID)
update #samplesubmits set SubmitCountLate = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmit WHERE DueDate < RecDate and pSampleRequestSubmit.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID)
update #samplesubmits set SubmitCountOther = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmit WHERE RecDate is null and pSampleRequestSubmit.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID)

update #samplesubmits set SubmitCountEarly = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE DueDate > RecDate and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) WHERE (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE DueDate > RecDate and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) > 0
update #samplesubmits set SubmitCountInTime = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE DueDate = RecDate and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) WHERE (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE DueDate = RecDate and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) > 0
update #samplesubmits set SubmitCountLate = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE DueDate < RecDate and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) WHERE (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE DueDate < RecDate and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) > 0
update #samplesubmits set SubmitCountOther = (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE RecDate is null and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) WHERE (SELECT COUNT(SampleRequestSubmitID) from pSampleRequestSubmitBOM WHERE RecDate is null and pSampleRequestSubmitBOM.SampleRequestTradeID = #samplesubmits.SampleRequestTradeID) > 0

select samplestyle.*, sh.StyleCategory from 
(select #samplesubmits.*, cast((ISNULL(CAST(srt.StyleID as nvarchar(40)),'') + ISNULL(CAST(srtbom.StyleID as nvarchar(40)),'')) as uniqueidentifier) as SampleStyleID from #samplesubmits
	left join pSampleRequestTrade srt on #samplesubmits.SampleRequestTradeID = srt.SampleRequestTradeID
	left join pSampleRequestBOMTrade srtbom on #samplesubmits.SampleRequestTradeID = srtbom.SampleRequestTradeID) samplestyle
left join pStyleHeader sh on samplestyle.SampleStyleID = sh.StyleID	

	
drop table #samplesubmits


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04491', GetDate())
GO
