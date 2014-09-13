
/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT]    Script Date: 01/09/2013 17:07:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT]    Script Date: 01/09/2013 17:07:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT] (
@MaterialTradePartnerID UNIQUEIDENTIFIER ,
@SeasonYearID UNIQUEIDENTIFIER
)
AS 

	DECLARE @TradePartnerID UNIQUEIDENTIFIER
	DECLARE @MaterialID UNIQUEIDENTIFIER
	
	SELECT @TradePartnerID = TradePartnerID, @MaterialID = MaterialID
	FROM pMaterialTradePartner 
	WHERE  MaterialTradePartnerID = @MaterialTradePartnerID

	SELECT MaterialTradePartnerID FROM pMaterialTradePartner 
	WHERE TradePartnerID = @TradePartnerID  
	AND MaterialID = @MaterialID
	AND SeasonYearID = @SeasonYearID 
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04730', GetDate())
GO
