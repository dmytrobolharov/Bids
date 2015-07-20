IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_QuoteItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_QuoteItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Style_QuoteItem_DELETE]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRAN	
			DELETE FROM pStyleQuoteComment WHERE StyleQuoteItemID = @StyleQuoteItemID	
			DELETE FROM pStyleQuoteItemTeam WHERE StyleQuoteItemID = @StyleQuoteItemID	
			DELETE FROM pStyleQuoteItemActivity WHERE StyleQuoteItemID = @StyleQuoteItemID	
			DELETE FROM pSourcingCostOption WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM pStyleQuoteDocument WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM hStyleQuoteHistory WHERE StyleQuoteItemID = @StyleQuoteItemID	
			DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID
			
			DELETE FROM pSourcingQuotationBOMOptionItems WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM pSourcingQuotationBOMDetails WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM pSourcingQuotationBOMOption WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM pSourcingQuotationBOMMaterials WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM pSourcingQuoteStyleBOM WHERE StyleQuoteItemID = @StyleQuoteItemID	
			
			DELETE FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @StyleQuoteItemID
			DELETE FROM pStyleQuoteItemVersion WHERE StyleQuoteItemID = @StyleQuoteItemID
			DELETE FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID		
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT @ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		-- Use RAISERROR inside the CATCH block to return error
		-- information about the original error that caused
		-- execution to jump to the CATCH block.
		RAISERROR (
			@ErrorMessage,  -- Message text.
			@ErrorSeverity, -- Severity.
			@ErrorState     -- State.
		);
	END CATCH
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06754', GetDate())
GO
