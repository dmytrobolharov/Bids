IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingQuoteItemCopyColors_UPDATE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingQuoteItemCopyColors_UPDATE_QUEUE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingQuoteItemCopyColors_UPDATE_QUEUE]
(
@StyleSourcingID UNIQUEIDENTIFIER ,
@StyleQuoteItemID UNIQUEIDENTIFIER
)
AS 
BEGIN 

	DECLARE @DUMMY INT
	

	DECLARE @StyleQuoteItemCustomField4 NVARCHAR(200)
	DECLARE @StyleQuoteItemCustomField5 decimal(18,3)
	DECLARE @StyleQuoteItemCustomField6 decimal(18,3)
	DECLARE @StyleQuoteItemCustomField7 decimal(18,5)
	DECLARE @StyleQuoteItemCustomField8 decimal(18,3) 
	DECLARE @StyleQuoteItemCustomField24 decimal(18,4)
	DECLARE @StyleQuoteItemStatusID INT 

	SELECT  @StyleQuoteItemCustomField4 = StyleQuoteItemCustomField4, @StyleQuoteItemCustomField5 = StyleQuoteItemCustomField5, 
	@StyleQuoteItemCustomField6 = StyleQuoteItemCustomField6, @StyleQuoteItemCustomField7 = StyleQuoteItemCustomField7 , 
	@StyleQuoteItemCustomField8 = StyleQuoteItemCustomField8,
	@StyleQuoteItemCustomField24 = StyleQuoteItemCustomField24,
	@StyleQuoteItemStatusID = StyleQuoteItemStatusID
	FROM pStyleQuoteItem 
	WHERE StyleQuoteItemID = @StyleQuoteItemID


	--select *from pStyleQuoteItem


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
		StyleQuoteItemCustomField24 = @StyleQuoteItemCustomField24,
		StyleQuoteItemStatusID = @StyleQuoteItemStatusID
		WHERE StyleQuoteItemID = @StyleQuoteItemID2

	
	
		EXEC dbo.spx_StyleSourcingQuoteItemLogic_UPDATE @StyleQuoteItemID2
		--PRINT 'AA = '  + cast (@StyleQuoteItemID2 AS NVARCHAR(50))
	
		EXEC dbo.spx_StyleSourcingQuoteItemVersion_UPDATE  @StyleQuoteItemID2			
		SET @ROW = @ROW + 1

	END 



	Select 1 as dummy

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06233', GetDate())
GO
