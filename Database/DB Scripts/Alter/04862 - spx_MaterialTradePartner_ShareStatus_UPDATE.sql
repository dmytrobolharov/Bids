/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartner_ShareStatus_UPDATE]    Script Date: 01/23/2013 16:16:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartner_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartner_ShareStatus_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartner_ShareStatus_UPDATE]    Script Date: 01/23/2013 16:16:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartner_ShareStatus_UPDATE]
(
	@MaterialTradePartnerID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@IsADD bit,
	@MUser nvarchar(200),
	@MDate datetime
)
AS 

BEGIN

IF @IsADD = 1
	BEGIN 
		IF NOT EXISTS (SELECT * FROM pMaterialTradePartnerShare WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND TradePartnerId = @TradePartnerID)
			INSERT INTO pMaterialTradePartnerShare (MaterialTradePartnerID, TradePartnerId, MUser, MDate) 
			VALUES(@MaterialTradePartnerID, @TradePartnerID, @MUser, @MDate)
	END
ELSE
	BEGIN
		DELETE FROM pMaterialTradePartnerShare WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND TradePartnerId = @TradePartnerID
	END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04862', GetDate())
GO
