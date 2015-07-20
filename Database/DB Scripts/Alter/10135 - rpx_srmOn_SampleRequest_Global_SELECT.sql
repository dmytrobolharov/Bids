IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_srmOn_SampleRequest_Global_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_srmOn_SampleRequest_Global_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_srmOn_SampleRequest_Global_SELECT]
	@TradePartnerID uniqueidentifier,
	@Season nvarchar(200) = null,
	@Year nvarchar(200) = null,
	@Category nvarchar(200) = null
AS


select	tp.TradePartnerName, 
		tpv.VendorName,
		cast(sh.StyleID as nvarchar(50)) as StyleID,
		sh.StyleNo, 
		sh.Description,
		sh.StyleSet, 
		sh.SizeClass,
		sh.SizeRange,
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
where	(srw.TradePartnerID = @TradePartnerID)
and 	(@Season is null or sh.CustomField2 = @Season)
and 	(@Year is null or sh.CustomField4 = @Year)
and 	(@Category is null or sh.CustomField5 = @Category)


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10135', GetUTCDate())
GO