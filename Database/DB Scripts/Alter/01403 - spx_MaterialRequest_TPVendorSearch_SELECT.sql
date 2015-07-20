IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequest_TPVendorSearch_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialRequest_TPVendorSearch_SELECT]
GO 


CREATE PROCEDURE dbo.spx_MaterialRequest_TPVendorSearch_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS

	SELECT '' AS TradePartnerVendorID, '' AS VendorName
	UNION
	SELECT CAST(TradePartnerVendorID AS NVARCHAR(40)), VendorName FROM dbo.uTradePartnerVendor a WITH(NOLOCK)
	WHERE a.TradePartnerID = @TradePartnerID
	
	
GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01403', GETDATE())
GO	

	