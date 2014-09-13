/****** Object:  StoredProcedure [dbo].[spx_SurcingQuote_CommitmentCostOption_INSERT]    Script Date: 01/30/2013 16:22:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SurcingQuote_CommitmentCostOption_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SurcingQuote_CommitmentCostOption_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SurcingQuote_CommitmentCostOption_INSERT]    Script Date: 01/30/2013 16:22:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SurcingQuote_CommitmentCostOption_INSERT]
	@CommitmentItemID UNIQUEIDENTIFIER,
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
	
	DECLARE @OptionNo INT = (SELECT COUNT(*) FROM pSourcingCommitmentCostOption WHERE CommitmentItemID = @CommitmentItemID) + 1

    -- Insert statements for procedure here
	INSERT INTO pSourcingCommitmentCostOption (
		SourcingCommitmentCostOptionID,
		CommitmentItemID,
		StyleQuoteItemID,
		OptionNo,
		OptionName,
		BOMOption,
		CUser,
		CDate
	) VALUES (
		@StyleOptionID,
		@CommitmentItemID,
		@StyleQuoteItemID,
		@OptionNo,
		'Option ' + CAST(@OptionNo as NVARCHAR(5)),
		@BOMOptionID,
		@CUser,
		@CDate
	)
	
	INSERT INTO pSourcingCommitmentCostOptionDetail
		(SourcingCommitmentCostOptionDetailID,
		SourcingCommitmentCostOptionId,
		SourcingQuotationBOMDetailsID,
		MinQuantity,
		MaxQuantity,
		CostUnit
		)
	SELECT NEWID(), @StyleOptionID, SourcingCommitmentBOMDetailsID,0,0,0.00
		
	FROM pSourcingCommitmentBOMDetails WHERE sourcingCommitmentItemID = @CommitmentItemID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04926', GetDate())
GO
