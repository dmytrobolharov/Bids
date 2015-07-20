IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerInfrastructureImage_LINK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerInfrastructureImage_LINK]
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerInfrastructureImage_LINK](
	@TradePartnerInfrastructureImageID UNIQUEIDENTIFIER,
	@TradePartnerInfrastructureID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER, 
	@ImageVersion INT, 
	@CreatedBy NVARCHAR(200), 
	@CreatedDate DATETIME)
AS
BEGIN

DECLARE @nSort AS INT
DECLARE @nMax AS INT
DECLARE @nCount AS INT

SELECT @nCount = COUNT(*)
FROM uTradePartnerInfrastructureImage WITH (NOLOCK)
WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID

SELECT @nMax = CAST(MAX(Sort) AS INT)
FROM uTradePartnerInfrastructureImage WITH (NOLOCK)
WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID

IF @nCount IS NULL
	SET @nCount = 0

IF @nMax IS NULL
	SET @nMax = 0

IF @nCount > @nMax
	SET @nSort = @nCount
ELSE
	SET @nSort = @nMax

SET @nSort = @nSort + 1

INSERT INTO uTradePartnerInfrastructureImage(
	TradePartnerInfrastructureImageID, TradePartnerInfrastructureID, ImageID, ImageVersion, Sort, IsLinked,
	ImageDescription, ImageName, ImageSize, ImageType,
	CUser, MUser, CDate, MDate)
SELECT @TradePartnerInfrastructureImageID, @TradePartnerInfrastructureID, @ImageID, @ImageVersion, @nSort, 1,
	ImageDescription, ImageFile, ImageSize, ImageType,
	@CreatedBy, @CreatedBy, @CreatedDate, @CreatedDate
FROM pImage WHERE ImageID = @ImageID

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06051', GetDate())
GO
