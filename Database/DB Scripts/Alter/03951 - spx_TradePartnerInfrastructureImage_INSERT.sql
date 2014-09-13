IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerInfrastructureImage_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerInfrastructureImage_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerInfrastructureImage_INSERT]
	(@TradePartnerInfrastructureImageID uniqueidentifier,
	@TradePartnerInfrastructureID uniqueidentifier,
	@ImageID uniqueidentifier,
	@ImageVersion int,
	@CreatedBy nvarchar(200),
	@CreatedDate datetime)
AS 
DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
BEGIN

	SELECT @nCount = count(*) FROM uTradePartnerInfrastructureImage WITH (NOLOCK) WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM uTradePartnerInfrastructureImage WITH (NOLOCK) WHERE TradePartnerInfrastructureID = @TradePartnerInfrastructureID
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	
	SET @nSort = @nSort + 1

INSERT INTO uTradePartnerInfrastructureImage
    (TradePartnerInfrastructureImageID, TradePartnerInfrastructureID, ImageID, ImageVersion, Sort, CUser, MUser, CDate, MDate)
VALUES   (@TradePartnerInfrastructureImageID, @TradePartnerInfrastructureID, @ImageID, @ImageVersion, @nSort, @CreatedBy, @CreatedBy, @CreatedDate, @CreatedDate)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03951', GetDate())
GO

