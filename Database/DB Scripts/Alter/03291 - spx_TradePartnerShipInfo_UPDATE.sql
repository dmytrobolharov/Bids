/****** Object:  StoredProcedure [dbo].[spx_TradePartnerShipInfo_UPDATE]    Script Date: 04/03/2012 17:37:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerShipInfo_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerShipInfo_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TradePartnerShipInfo_UPDATE]    Script Date: 04/03/2012 17:37:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerShipInfo_UPDATE]
	@TradePartnerShipInfoID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER,
	@ShipTypeID UNIQUEIDENTIFIER,
	@ShipModeID UNIQUEIDENTIFIER,
	@TradePointID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @ShipTypeID IS NULL OR @ShipModeID IS NULL OR @TradePointID IS NULL
	BEGIN
		RETURN
	END
	
	IF NOT EXISTS (SELECT * FROM uTradePartnerShipInfo
					WHERE TradePartnerID = @TradePartnerID 
						AND ShipTypeID = @ShipTypeID 
						AND ShipModeID = @ShipModeID 
						AND TradePointID = @TradePointID)
	BEGIN	
		IF @TradePartnerShipInfoID IS NULL
		BEGIN
			INSERT INTO uTradePartnerShipInfo(TradePartnerID, ShipTypeID, ShipModeID, TradePointID, CUser, CDate, MUser, MDate)
			VALUES (@TradePartnerID, @ShipTypeID, @ShipModeID, @TradePointID, @CUser, @CDate, @CUser, @CDate)
		END
		ELSE
		BEGIN
			UPDATE uTradePartnerShipInfo
			SET ShipTypeID = @ShipTypeID,
				ShipModeID = @ShipModeID,
				TradePointID = @TradePointID,
				MUser = @CUser,
				MDate = @CDate
			WHERE TradePartnerShipInfoID = @TradePartnerShipInfoID
		END
	END
	ELSE
		SELECT 'Duplicated Values'
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03291'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03291', GetDate())
END
GO