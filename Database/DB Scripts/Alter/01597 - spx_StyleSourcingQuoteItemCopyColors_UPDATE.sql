IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingQuoteItemCopyColors_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSourcingQuoteItemCopyColors_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingQuoteItemCopyColors_UPDATE] (
	@StyleSourcingID UNIQUEIDENTIFIER,
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 


DECLARE @pStyleSourcingID NVARCHAR(70)
DECLARE @pStyleQuoteItemID NVARCHAR(70)

IF @StyleSourcingID IS NULL
	SET @pStyleSourcingID = ' @StyleSourcingID = NULL '
ELSE
	SET @pStyleSourcingID = ' @StyleSourcingID = ''' +  CAST (@StyleSourcingID AS NVARCHAR(50)) + ''' '

IF @StyleQuoteItemID IS NULL
	SET @pStyleQuoteItemID = ' @StyleQuoteItemID = NULL '
ELSE
	SET @pStyleQuoteItemID = ' @StyleQuoteItemID = ''' +  CAST (@StyleQuoteItemID AS NVARCHAR(50)) + ''' '



DECLARE @ServiceDate DATETIME
SET @ServiceDate = getdate()

DECLARE @ServiceQueueSql1 nvarchar(4000)
SET @ServiceQueueSql1 = 'dbo.spx_StyleSourcingQuoteItemCopyColors_UPDATE_QUEUE ' + 
@pStyleSourcingID + ',' + 
@pStyleQuoteItemID

exec spx_ServiceQueue_INSERT @ServiceQueueSql = @ServiceQueueSql1, @ServiceQueuePriority = 1, @ServiceQueueDate = @ServiceDate


/*

	BEGIN 

	DECLARE @DUMMY INT
	

	DECLARE @StyleQuoteItemCustomField4 NVARCHAR(200)
	DECLARE @StyleQuoteItemCustomField5 NVARCHAR(200)
	DECLARE @StyleQuoteItemCustomField6 NVARCHAR(200)
	DECLARE @StyleQuoteItemCustomField7 UNIQUEIDENTIFIER
	DECLARE @StyleQuoteItemCustomField8 MONEY 
	DECLARE @StyleQuoteItemCustomField24 NVARCHAR(200)

	SELECT  @StyleQuoteItemCustomField4 = StyleQuoteItemCustomField4, @StyleQuoteItemCustomField5 = StyleQuoteItemCustomField5, 
	@StyleQuoteItemCustomField6 = StyleQuoteItemCustomField6, @StyleQuoteItemCustomField7 = StyleQuoteItemCustomField7 , 
	@StyleQuoteItemCustomField8 = StyleQuoteItemCustomField8,
	@StyleQuoteItemCustomField24 = StyleQuoteItemCustomField24
	FROM pStyleQuoteItem 
	WHERE StyleQuoteItemID = @StyleQuoteItemID


	CREATE TABLE #StyleQuoteItem (
		ROW_ID INT IDENTITY (1,1),
		StyleQuoteItemID UNIQUEIDENTIFIER 
	)	


	INSERT INTO  #StyleQuoteItem  (StyleQuoteItemID)
	SELECT StyleQuoteItemID FROM pStyleQuoteItem WHERE StyleSourcingID = @StyleSourcingID 

	DECLARE @ROW INT
	DECLARE @TOTAL INT 
	DECLARE @StyleQuoteItemID2 UNIQUEIDENTIFIER 

	SET @ROW = 1 
	SELECT @TOTAL  = COUNT (*) FROM #StyleQuoteItem 
	

	WHILE @ROW <= @TOTAL 
	BEGIN 
		SELECT @StyleQuoteItemID2 = StyleQuoteItemID
		FROM  #StyleQuoteItem
		WHERE ROW_ID  = @ROW

		UPDATE pStyleQuoteItem SET 
		StyleQuoteItemCustomField4 = @StyleQuoteItemCustomField4, 
		StyleQuoteItemCustomField5 = @StyleQuoteItemCustomField5, 
		StyleQuoteItemCustomField6 = @StyleQuoteItemCustomField6, 
		StyleQuoteItemCustomField7 = @StyleQuoteItemCustomField7 , 
		StyleQuoteItemCustomField8 = @StyleQuoteItemCustomField8 ,
		StyleQuoteItemCustomField24 = @StyleQuoteItemCustomField24
		WHERE StyleQuoteItemID = @StyleQuoteItemID2

		
		EXEC dbo.spx_StyleSourcingQuoteItemLogic_UPDATE @StyleQuoteItemID2
		PRINT 'AA = '  + cast (@StyleQuoteItemID2 AS NVARCHAR(50))
	
		EXEC dbo.spx_StyleSourcingQuoteItemVersion_UPDATE  @StyleQuoteItemID2			
		SET @ROW = @ROW + 1

	END 



	Select 1 as dummy

END 

*/

go 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01597'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01597', GetDate())
END	

GO











