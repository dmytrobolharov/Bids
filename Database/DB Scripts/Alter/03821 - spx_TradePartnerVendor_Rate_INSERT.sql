IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerVendor_Rate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerVendor_Rate_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerVendor_Rate_INSERT] (
@TradePartnerVendorRateID UNIQUEIDENTIFIER,
@NewTradePartnerVendorRateID UNIQUEIDENTIFIER,
@FieldsSelected NVARCHAR(4000) ,
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS 
	
DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER

SELECT @TradePartnerVendorID = TradePartnerVendorID  
FROM pTradePartnerVendorRate WITH(NOLOCK)
WHERE TradePartnerVendorRateID = @TradePartnerVendorRateID	
	
INSERT INTO  pTradePartnerVendorRate ( TradePartnerVendorRateID , TradePartnerVendorID, CUser, CDate, MUser, MDate )
VALUES (@NewTradePartnerVendorRateID, @TradePartnerVendorID, @CUser, @CDate, @CUser, @CDate )  
	

/***
** Copy all Items
	
DECLARE @SQL AS NVARCHAR(4000)
IF LEN (@FieldsSelected) > 0 
BEGIN 
	SET @SQL = 'INSERT INTO pTradePartnerVendorRateItem( TradepartnerVendorRateItemID, TradePartnerVendorRateID, StyleCategoryID, 
	Rate, CDate, CUser, MUser, MDate, ' +  @FieldsSelected + ') 
	SELECT NewID(), ''' + CAST(@NewTradePartnerVendorRateID AS NVARCHAR(40))  + ''', StyleCategoryID, Rate, '''  +
	CAST(@CDate AS NVARCHAR(20))  + ''', ''' +  @CUser + ''',  ''' +  @CUser + ''',  ''' +  CAST(@CDate AS NVARCHAR(20)) + ''', ' + @FieldsSelected + '
	FROM pTradePartnerVendorRateItem WITH(NOLOCK) WHERE TradePartnerVendorRateID =  '''  + CAST(@TradePartnerVendorRateID  AS NVARCHAR(40)) + ''' '
END 
ELSE 
BEGIN
	SET @SQL = 'INSERT INTO pTradePartnerVendorRateItem( TradepartnerVendorRateItemID, TradePartnerVendorRateID, StyleCategoryID, 
	Rate, CDate, CUser, MUser, MDate )   
	SELECT NewID(), ''' + CAST(@NewTradePartnerVendorRateID AS NVARCHAR(40))  + ''', StyleCategoryID, Rate, '''  +
	CAST(@CDate AS NVARCHAR(20))  + ''', ''' +  @CUser + ''',  ''' +  @CUser + ''',  ''' +  CAST(@CDate AS NVARCHAR(20)) + '''  
	FROM pTradePartnerVendorRateItem WITH(NOLOCK) WHERE TradePartnerVendorRateID =  '''  + CAST(@TradePartnerVendorRateID  AS NVARCHAR(40)) + ''' '
END 

EXECUTE sp_executesql @SQL
***/
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03821', GetDate())
GO
