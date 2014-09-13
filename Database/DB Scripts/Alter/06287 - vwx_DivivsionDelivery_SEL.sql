IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_DivivsionDelivery_SEL]'))
DROP VIEW [dbo].[vwx_DivivsionDelivery_SEL]
GO

CREATE VIEW [dbo].[vwx_DivivsionDelivery_SEL]
AS
SELECT
	d.DeliveryID
	, ISNULL(dd.DivisionActive,0) AS DivisionActive
	, d.DeliveryCode
	, d.DeliveryName
	, d.Active
	, div.CustomID
FROM pBrandDelivery bd
	INNER JOIN iCustom1 div ON bd.BrandID = div.BrandID
	INNER JOIN pDelivery d ON  bd.DeliveryID = d.DeliveryID
	INNER JOIN pDivisionDelivery dd ON d.DeliveryID = dd.DeliveryID AND div.CustomID = dd.DivisionID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06287', GetDate())
GO
