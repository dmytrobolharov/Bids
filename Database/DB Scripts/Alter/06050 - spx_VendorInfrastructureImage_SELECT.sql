IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorInfrastructureImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorInfrastructureImage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_VendorInfrastructureImage_SELECT](
	@TradePartnerID UNIQUEIDENTIFIER,
	@TradePartnerInfrastructureID UNIQUEIDENTIFIER)
AS
	
/*Get Image Server path portion.*/
DECLARE @ImageServer nvarchar(200) = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer') 

SELECT '<img src="' + @ImageServer + '/ImageStream.ashx?IT=VINF&TPID=' + CAST(@TradePartnerID AS VARCHAR(40)) + '&TINFID=' + 
		CAST(@TradePartnerInfrastructureID AS VARCHAR(40)) + '&L=0&Comp=100&S=100&TINFIID=' + CAST(a.TradePartnerInfrastructureImageID AS VARCHAR(40)) 
			+ '&IID=' + CAST(a.ImageID AS VARCHAR(40)) + '&V=' + CAST(a.ImageVersion AS NVARCHAR(5)) + '" />' AS sImage, 
	a.TradePartnerInfrastructureImageID, a.TradePartnerInfrastructureID, 
	a.ImageDescription, a.MUser, a.IsLinked, a.Sort
FROM uTradePartnerInfrastructureImage a WITH (NOLOCK)
WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID AND IsLinked = 0

UNION ALL

SELECT '<img src="' + @ImageServer + '/ImageStream.ashx?S=100&V=' + CAST(ImageVersion AS VARCHAR(5)) + '&IID=' + CAST(a.ImageID AS VARCHAR(255)) + '" />' AS sImage,
	a.TradePartnerInfrastructureImageID, a.TradePartnerInfrastructureID, 
	i.ImageDescription, a.MUser, a.IsLinked, a.Sort
FROM uTradePartnerInfrastructureImage a WITH (NOLOCK)
LEFT JOIN hImage i ON a.ImageID = i.ImageID AND a.ImageVersion = i.Version
WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID AND IsLinked = 1
ORDER BY Sort  

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06050', GetDate())
GO
