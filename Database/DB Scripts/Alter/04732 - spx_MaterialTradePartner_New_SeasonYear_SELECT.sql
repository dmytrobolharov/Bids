/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]    Script Date: 01/09/2013 14:53:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]    Script Date: 01/09/2013 14:53:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]
	@MaterialID UNIQUEIDENTIFIER , 
	@MaterialTradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	DECLARE @TradePartnerID UNIQUEIDENTIFIER 

	SELECT @TradePartnerID = TradePartnerID , @SeasonYearID = SeasonYearID
	FROM pMaterialTradePartner  
	WHERE MaterialTradePartnerID = @MaterialTradePartnerID 

	SELECT DISTINCT a.SeasonYearID,  b.Season + ' ' + b.Year AS SeasonYear , a.TradePartnerVendorID
	FROM pMaterialTradePartner  a  
	INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
	WHERE  MaterialID = @MaterialID
	AND TradePartnerID = @TradePartnerID
END

SELECT @SeasonYearID AS SeasonYearID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04732', GetDate())
GO
