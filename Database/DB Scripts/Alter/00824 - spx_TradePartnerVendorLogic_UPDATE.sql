IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerVendorLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_TradePartnerVendorLogic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerVendorLogic_UPDATE](
	@TradePartnerVendorID UNIQUEIDENTIFIER,
	@MDate DATETIME,
	@MUser NVARCHAR(200),
	@ChangeTransUserID UNIQUEIDENTIFIER
)
AS


CREATE TABLE #sqi (
	ROWID INT IDENTITY (1,1),
	StyleQuoteItemID UNIQUEIDENTIFIER,
	StyleID  UNIQUEIDENTIFIER
)

DECLARE 
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER, 
	@TOTAL INT,
	@ROWID INT,
	@ChangeTransID UNIQUEIDENTIFIER
		

INSERT INTO #sqi ( StyleQuoteItemID, StyleID)
SELECT StyleQuoteItemID, StyleID
FROM dbo.pStyleQuoteItem
WHERE TradePartnerVendorID = @TradePartnerVendorID


SET @ROWID = 1
SELECT @TOTAL =COUNT(*) FROM #sqi 
	
WHILE @ROWID <= @TOTAL 
BEGIN
	SELECT @StyleQuoteItemID = StyleQuoteItemID, @StyleID = StyleID
	FROM #sqi WHERE ROWID =@ROWID
	
	SET @ChangeTransID =  NEWID()
	
	--** TechPack exists ? 
	IF EXISTS ( SELECT  * FROM dbo.pStyleHeader a
			INNER JOIN dbo.pTechPack b ON a.TechPackId =  b.TechPackID
			WHERE a.StyleID = @StyleID
	)
	BEGIN 
		
		--** Insert Transaction 
		INSERT INTO pChangeTransaction( ChangeTransID, ChangeTransPageName , 
			ChangeTransTableID, ChangeTransTablePKID, ChangeTransUserID, ChangeTransDate, ChangeTransTypeID) 
		VALUES( @ChangeTransID, '', 
			'D612FAAE-7ACD-DF11-AF06-005056C00008', 
			@StyleID, @ChangeTransUserID, @MDate, 0 )  -- ** ChangeTransTypeID=0 FOR update
		
		EXEC dbo.spx_StyleQuoteItemLogic_UPDATE
			@StyleQuoteItemID = @StyleQuoteItemID,
			@ChangeTransID = @ChangeTransID,
			@ChangeTransUserID = @ChangeTransUserID,
			@MUser = @MUser,
			@MDate = @MDate
			
		IF NOT EXISTS ( SELECT * FROM dbo.pChangeLogItem WHERE ChangeTransID = @ChangeTransID )
			DELETE FROM dbo.pChangeTransaction WHERE ChangeTransID = @ChangeTransID	
			
	END 
	
	


	SET @ROWID = @ROWID + 1 
	
END		





