IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlExchangeRateItem_Logic_UPDATE_QUEUE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ControlExchangeRateItem_Logic_UPDATE_QUEUE]
GO

CREATE PROCEDURE [dbo].[spx_ControlExchangeRateItem_Logic_UPDATE_QUEUE] (
	@ExchangeRateItemID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 


CREATE TABLE #tmp (
	ROWID INT IDENTITY(1,1),
	TradePartnerVendorRateItemID UNIQUEIDENTIFIER
)

INSERT INTO #tmp (TradePartnerVendorRateItemID)
SELECT a.TradePartnerVendorRateItemID
FROM pTradePartnerVendorRateItem a
	INNER JOIN dbo.pTradePartnerVendorRate b ON a.TradePartnerVendorRateID = b.TradePartnerVendorRateID
	INNER JOIN dbo.sExchangeRate c ON c.ExchangeRateID =  b.ExchangeRate
	INNER JOIN sExchangeRateItem d ON d.ExchangeRateID = c.ExchangeRateID 
		AND d.CurrencyType = b.CurrencyType
WHERE ExchangeRateItemID = @ExchangeRateItemID --'582cd311-6213-4984-9411-b3840ee6c3bc' 



DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@TradePartnerVendorRateItemID UNIQUEIDENTIFIER,
	@pTradePartnerVendorRateItemID NVARCHAR (100),
	@pMUser NVARCHAR(250),
	@pMDate NVARCHAR(100),
	@ServiceQueueSql1 nvarchar(4000)

	

SET @ROWID  = 1 
SELECT @TOTAL = COUNT(*) FROM #tmp


IF @MUser IS NULL
	SET @pMUser = ' @MUser = NULL '
ELSE
	SET @pMUser= ' @MUser = ''' +  @MUser  + ''' '

IF @MDate IS NULL
	SET @pMDate = ' @MDate = NULL '
ELSE
	SET @pMDate= ' @MDate = ''' +  CONVERT( NVARCHAR(40) , @MDate  , 20 ) + ''' '



WHILE  @ROWID <= @TOTAL 
BEGIN
	SELECT @TradePartnerVendorRateItemID = TradePartnerVendorRateItemID
	FROM #tmp WHERE ROWID = @ROWID


	SET @pTradePartnerVendorRateItemID = ' @TradePartnerVendorRateItemID = ''' +  CAST (@TradePartnerVendorRateItemID AS NVARCHAR(50)) + ''' '

	SET @ServiceQueueSql1 = 'dbo.spx_ControlTradePartnerVendorRateItem_Logic_UPDATE ' + 
	@pTradePartnerVendorRateItemID + ',' + 
	@pMUser + ',' + 
	@pMDate

	EXEC spx_ServiceQueue_INSERT 
		@ServiceQueueSql = @ServiceQueueSql1, 
		@ServiceQueuePriority = 1, 
		@ServiceQueueDate = @MDate


	
	--EXEC spx_ControlTradePartnerVendorRateItem_Logic_UPDATE
	--	@TradePartnerVendorRateItemID = @TradePartnerVendorRateItemID,
	--	@MUser = @MUser,
	--	@MDate = @MDate
	

	SET @ROWID = @ROWID + 1 
	
END 


DROP TABLE #tmp

	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01133', GetDate())
GO







