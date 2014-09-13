

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_CostOption_INSERT]    Script Date: 02/07/2013 21:02:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_CostOption_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_CostOption_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_CostOption_INSERT]    Script Date: 02/07/2013 21:02:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create PROCEDURE [dbo].[spx_SourcingQuote_CostOption_INSERT]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@StyleOptionID UNIQUEIDENTIFIER,
	@BOMOptionID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @OptionNo INT = (SELECT COUNT(*) FROM pSourcingCostOption WHERE StyleQuoteItemID = @StyleQuoteItemID) + 1

    -- Insert statements for procedure here
	INSERT INTO pSourcingCostOption (
		SourcingCostOptionID,
		StyleQuoteItemID,
		OptionNo,
		OptionName,
		BOMOption,
		CUser,
		CDate
	) VALUES (
		@StyleOptionID,
		@StyleQuoteItemID,
		@OptionNo,
		'Option ' + CAST(@OptionNo as NVARCHAR(5)),
		@BOMOptionID,
		@CUser,
		@CDate
	)
	
	INSERT INTO pSourcingCostOptionDetail
		(SourcingCostOptionDetailID,
		SourcingCostOptionId,
		SourcingQuotationBOMDetailsID,
		MinQuantity,
		MaxQuantity,
		CostUnit
		)
	SELECT NEWID(), @StyleOptionID, SourcingQuotationBOMDetailsID,0,0,0.00
		
	FROM pSourcingQuotationBOMDetails WHERE StyleQuoteItemID = @StyleQuoteItemID
	
END



GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05002', GetDate())
GO