/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/



ALTER   proc [dbo].[rpx_SampleRequest_Global_SELECT]
	@Agent nvarchar(200) = null,
	@Season nvarchar(200) = null,
	@Year nvarchar(200) = null,
	@Category nvarchar(200) = null
as


select	tp.TradePartnerName, 
		tpv.VendorName,
		cast(sh.StyleID as varchar(50)) as StyleID,
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
		dbo.fnx_GetStreamingImagePath(i.ImageID, i.[Version]) AS FilePath	--Comment #01
from	pSampleRequestWorkflow srw
inner join	pSampleWorkflow sw on srw.SampleWorkflowID = sw.SampleWorkflowID
inner join	pStyleHeader sh on srw.StyleID = sh.StyleID
inner join	uTradePartner tp on srw.TradePartnerID = tp.TradePartnerID
inner join	uTradePartnerVendor tpv on srw.TradePartnerVendorID = tpv.TradePartnerVendorID
left outer join	pStyleColorway sc on srw.StyleColorID = sc.StyleColorID
left outer join	hImage i on sh.DesignSketchID = i.ImageID and sh.DesignSketchVersion = i.Version
where	(@Agent is null or srw.TradePartnerID = @Agent)
and 	(@Season is null or sh.CustomField2 = @Season)
and 	(@Year is null or sh.CustomField4 = @Year)
and 	(@Category is null or sh.CustomField5 = @Category)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '843', GetDate())
GO