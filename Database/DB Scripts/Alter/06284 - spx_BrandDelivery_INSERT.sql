IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BrandDelivery_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BrandDelivery_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BrandDelivery_INSERT]
	@DeliveryId UNIQUEIDENTIFIER, 
	@Brands VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pBrandDelivery WHERE DeliveryID = @DeliveryId
	
	INSERT INTO pBrandDelivery (DeliveryID, BrandID)
	SELECT @DeliveryId, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@Brands,',')

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06284', GetDate())
GO
