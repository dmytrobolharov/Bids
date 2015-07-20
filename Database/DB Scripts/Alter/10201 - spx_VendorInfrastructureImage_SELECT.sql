IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorInfrastructureImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorInfrastructureImage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_VendorInfrastructureImage_SELECT]
(
	@TradePartnerID UNIQUEIDENTIFIER
	, @TradePartnerInfrastructureID UNIQUEIDENTIFIER
)
AS
BEGIN

	SELECT '<img src="' + dbo.fnx_GetStreamingImagePathInfrastructure(ImageID, @TradePartnerID, @TradePartnerInfrastructureID, TradePartnerInfrastructureImageID, 100, ImageVersion) + '" />' AS sImage
		, TradePartnerInfrastructureImageID
		, TradePartnerInfrastructureID
		, ImageDescription
		, MUser
		, IsLinked
		, Sort
	FROM uTradePartnerInfrastructureImage
	WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID
		AND IsLinked = 0

	UNION ALL

	SELECT '<img src="' + dbo.fnx_GetStreamingImagePath(uTradePartnerInfrastructureImage.ImageID, ImageVersion, 500) + '" />' AS sImage
		, uTradePartnerInfrastructureImage.TradePartnerInfrastructureImageID
		, uTradePartnerInfrastructureImage.TradePartnerInfrastructureID
		, hImage.ImageDescription
		, uTradePartnerInfrastructureImage.MUser
		, uTradePartnerInfrastructureImage.IsLinked
		, uTradePartnerInfrastructureImage.Sort
	FROM uTradePartnerInfrastructureImage
		LEFT JOIN hImage ON uTradePartnerInfrastructureImage.ImageID = hImage.ImageID
			AND uTradePartnerInfrastructureImage.ImageVersion = hImage.Version
	WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID
		AND IsLinked = 1
	ORDER BY Sort

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10201', GetUTCDate())
GO