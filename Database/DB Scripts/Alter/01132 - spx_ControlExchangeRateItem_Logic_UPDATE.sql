IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlExchangeRateItem_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ControlExchangeRateItem_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ControlExchangeRateItem_Logic_UPDATE] (
	@ExchangeRateItemID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 




DECLARE 
	@pExchangeRateItemID NVARCHAR (70),
	@pMUser NVARCHAR(250),
	@pMDate NVARCHAR(100),
	@ServiceQueueSql1 nvarchar(4000)

	


IF @MUser IS NULL
	SET @pMUser = ' @MUser = NULL '
ELSE
	SET @pMUser= ' @MUser = ''' +  @MUser  + ''' '

IF @MDate IS NULL
	SET @pMDate = ' @MDate = NULL '
ELSE
	SET @pMDate= ' @MDate = ''' +  CONVERT( NVARCHAR(40) , @MDate  , 20 ) + ''' '

SET @pExchangeRateItemID = ' @ExchangeRateItemID = ''' +  CAST (@ExchangeRateItemID AS NVARCHAR(50)) + ''' '

SET @ServiceQueueSql1 = 'dbo.spx_ControlExchangeRateItem_Logic_UPDATE_QUEUE ' + 
@pExchangeRateItemID + ',' + 
@pMUser + ',' + 
@pMDate

EXEC spx_ServiceQueue_INSERT 
	@ServiceQueueSql = @ServiceQueueSql1, 
	@ServiceQueuePriority = 1, 
	@ServiceQueueDate = @MDate
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01132', GetDate())
GO





