/****** Object:  StoredProcedure [dbo].[spx_SurcingQuote_CostOption_INSERT]    Script Date: 01/24/2013 19:11:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SurcingQuote_CostOption_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SurcingQuote_CostOption_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_SurcingQuote_CostOption_INSERT]    Script Date: 01/24/2013 19:11:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SurcingQuote_CostOption_INSERT]
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
VALUES     ('DB_Version', '5.0.0000', '04892', GetDate())
GO
