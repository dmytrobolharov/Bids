/****** Object:  StoredProcedure [dbo].[spx_NPMSampleWorkflowSubmitVendors_SELECT]    Script Date: 03/01/2013 12:03:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleWorkflowSubmitVendors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitVendors_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleWorkflowSubmitVendors_SELECT]    Script Date: 03/01/2013 12:03:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitVendors_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS


	SELECT a.SampleRequestSubmitVendorID, 
			(a.VendorType + '-' + b.TradePartnerName) AS VendorName
	FROM pSampleRequestSubmitVendor a
		INNER JOIN dbo.uTradePartner b ON a.TradePartnerVendorID = b.TradePartnerID
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	ORDER BY a.VendorType


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05207', GetDate())
GO
