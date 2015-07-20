IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequest_Global_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequest_Global_SELECT]
GO

CREATE   proc [dbo].[rpx_SampleRequest_Global_SELECT]
	@Agent nvarchar(200) = null,
	@Season nvarchar(200) = null,
	@Year nvarchar(200) = null,
	@Category nvarchar(200) = null
as


select	tp.TradePartnerName, 
		tpv.VendorName,
		cast(sh.StyleID as nvarchar(50)) as StyleID,
		sh.StyleNo, 
		sh.Description,
		sh.StyleSet, 
		COALESCE(scc.Custom, sh.SizeClass) AS SizeClass,
		COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
		ISNULL(sc.MainColor,'NA') AS Color, 
		sh.DueDate AS [Tech Pack],
		sw.SampleWorkflowID,
		sw.SampleWorkflow,
		srw.DueDate,
		srw.EndDate,
		dbo.fnx_GetStreamingImagePath(i.ImageID, i.[Version], 2000) AS FilePath	--Comment #01
from	pSampleRequestWorkflow srw
inner join	pSampleWorkflow sw on srw.SampleWorkflowID = sw.SampleWorkflowID
inner join	pStyleHeader sh on srw.StyleID = sh.StyleID
inner join	uTradePartner tp on srw.TradePartnerID = tp.TradePartnerID
inner join	uTradePartnerVendor tpv on srw.TradePartnerVendorID = tpv.TradePartnerVendorID
left outer join	pStyleColorway sc on srw.StyleColorID = sc.StyleColorID
left outer join	hImage i on sh.DesignSketchID = i.ImageID and sh.DesignSketchVersion = i.Version
left join pSizeClass scc ON scc.CustomID = sh.SizeClassId
left join pSizeRange sr ON sr.CustomId = sh.SizeRangeId
where	(@Agent is null or srw.TradePartnerID = @Agent)
and 	(@Season is null or sh.CustomField2 = @Season)
and 	(@Year is null or sh.CustomField4 = @Year)
and 	(@Category is null or sh.CustomField5 = @Category)


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10128', GetUTCDate())
GO