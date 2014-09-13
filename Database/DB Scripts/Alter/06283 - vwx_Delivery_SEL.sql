IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Delivery_SEL]'))
DROP VIEW [dbo].[vwx_Delivery_SEL]
GO

CREATE VIEW [dbo].[vwx_Delivery_SEL]
AS
SELECT dbo.pDelivery.*
	, STUFF((
			SELECT ', ' + pBrand.Custom
			FROM pBrandDelivery
			LEFT JOIN pBrand ON pBrandDelivery.BrandID = pBrand.CustomID
			WHERE pBrandDelivery.DeliveryID = pDelivery.DeliveryID
			FOR XML PATH('')
			), 1, 2, '') AS Brands
FROM dbo.pDelivery
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06283', GetDate())
GO
