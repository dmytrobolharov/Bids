IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FlashEdit_QuoteItemLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_FlashEdit_QuoteItemLogic_UPDATE]
GO

CREATE PROCEDURE dbo.spx_FlashEdit_QuoteItemLogic_UPDATE(
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@SQL NVARCHAR(MAX),
	@MDate DATETIME,
	@TeamID UNIQUEIDENTIFIER
)
AS

DECLARE 
	@StyleID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@cStyleQuoteItemStatusId INT,
	@cStyleQuoteItemCustomField8 MONEY, --Ex Factory(local)
	@nStyleQuoteItemStatusId INT,
	@nStyleQuoteItemCustomField8 MONEY --Ex Factory(local)
	
	SELECT @StyleID = StyleID FROM dbo.pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID
	SELECT @MUser = ISNULL(UserName,'') + ' ' + ISNULL(LastName  ,'') FROM dbo.Users WHERE TeamID = @TeamID

	SELECT @cStyleQuoteItemCustomField8 = StyleQuoteItemCustomField8, @cStyleQuoteItemStatusId = StyleQuoteItemStatusId
	FROM dbo.pStyleQuoteItem WITH(NOLOCK) 
	WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	EXEC sp_executesql @SQL

	SELECT @nStyleQuoteItemCustomField8 = StyleQuoteItemCustomField8, @nStyleQuoteItemStatusId = StyleQuoteItemStatusId
	FROM dbo.pStyleQuoteItem WITH(NOLOCK) 
	WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	IF @cStyleQuoteItemCustomField8 <> @nStyleQuoteItemCustomField8 OR 
		@cStyleQuoteItemStatusId <> @nStyleQuoteItemStatusId
	BEGIN
	
		--** Create changeTransaction and call logic update 
		DECLARE 
			@ChangeLogID UNIQUEIDENTIFIER,
			@Change INT,
			@ChangeTransID UNIQUEIDENTIFIER
		
		SET @Change = 0 
		
		SET @ChangeTransID = NEWID()
		
		INSERT INTO pChangeTransaction( ChangeTransID, ChangeTransPageName , 
			ChangeTransTableID, ChangeTransTablePKID, ChangeTransUserID, ChangeTransDate, ChangeTransTypeID) 
		VALUES( @ChangeTransID, '', 
			'D612FAAE-7ACD-DF11-AF06-005056C00008', @StyleID, @TeamID, @MDate, 0 )  -- ** ChangeTransTypeID=1 FOR UPDATE
		
		EXECUTE spx_ChangeLog_INSERTID
			@changeTableId = '00000009-c1cc-df11-af06-005056c00008',  -- for StyleQuoteItem
			@changeTransId = @ChangeTransID,
			@changeTablePKId = @StyleQuoteItemID,
			@changeUserId = @TeamID, 
			@ChangeUserName = @MUser,
			@changeDate = @MDate,
			@changeSort = '0000',
			@ShowResult = 0,
			@ChangeLogID = @ChangeLogID OUTPUT			
			
		IF @cStyleQuoteItemCustomField8 <> @nStyleQuoteItemCustomField8 
		BEGIN 
			-- Ex Factory(local)
			EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,@ChangeSort = '0001',
			@ChangeFieldName = 'StyleQuoteItemCustomField8', @ChangeFieldAlias = 'Ex Factory(local)',
			@ChangeBeforeValue = @cStyleQuoteItemCustomField8, @ChangeAfterValue = @nStyleQuoteItemCustomField8,
			@ChangeBeforeText = @cStyleQuoteItemCustomField8, @ChangeAfterText = @nStyleQuoteItemCustomField8
		END 

		
		IF @cStyleQuoteItemStatusId <> @nStyleQuoteItemStatusId 
		BEGIN 
			-- Status
			EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,@ChangeSort = '0001',
			@ChangeFieldName = 'StyleQuoteItemStatusId', @ChangeFieldAlias = 'Status',
			@ChangeBeforeValue = @cStyleQuoteItemStatusId, @ChangeAfterValue = @nStyleQuoteItemStatusId,
			@ChangeBeforeText = @cStyleQuoteItemStatusId, @ChangeAfterText = @nStyleQuoteItemStatusId
		END 

		EXECUTE spx_StyleSourcingQuoteItemLogic_UPDATE
			@StyleQuoteItemID  = @StyleQuoteItemID,
			@ChangeTransID = @ChangeTransID,
			@ChangeTransUserID = @TeamID,
			@MUser = @MUser ,
			@MDate = @MDate
		
	
	END  -- IF change 


	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01135', GetDate())
GO





