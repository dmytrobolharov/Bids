IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlTradePartnerRate_StyleCategory_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ControlTradePartnerRate_StyleCategory_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_ControlTradePartnerRate_StyleCategory_SELECT](
	@TradePartnerVendorRateID UNIQUEIDENTIFIER
)
AS

	DECLARE @CDate  DATETIME
	SET @CDate  = GETUTCDATE()

	INSERT INTO  pTradePartnerVendorRateItem ( 
		TradePartnerVendorRateItemID, TradePartnerVendorRateID, StyleCategoryID, 
		Rate, CDate, CUser, Margin, Commission)
	SELECT NEWID() AS TradePartnerVendorRateItemID, @TradePartnerVendorRateID AS TradePartnerVendorRateID, a.StyleCategoryID, 0 as  Rate, 
	@CDate AS CDate, 'SYSTEM' AS CUser, 0 AS Margin, 0 AS Commission
	FROM dbo.pStyleCategory	a
		LEFT OUTER JOIN pTradePartnerVendorRateItem b ON a.StyleCategoryID = b.StyleCategoryID
			AND b.TradePartnerVendorRateID = @TradePartnerVendorRateID
	WHERE b.StyleCategoryID IS NULL 
	


	SELECT a.TradePartnerVendorRateItemID,  a.StyleCategoryID , a.Rate, b.StyleCategory,a.Margin, a.Commission
	FROM pTradePartnerVendorRateItem a WITH(NOLOCK)
		INNER JOIN pStyleCategory  b WITH(NOLOCK) ON a.StyleCategoryID  =  b.StyleCategoryID 
	WHERE TradePartnerVendorRateID = @TradePartnerVendorRateID
	ORDER BY b.StyleCategory


GO

