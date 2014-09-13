/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_CostOption_SELECT]    Script Date: 01/24/2013 19:09:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_CostOption_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_CostOption_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_CostOption_SELECT]    Script Date: 01/24/2013 19:09:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleQuote_CostOption_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM pSourcingCostOption WHERE StyleQuoteItemID = @StyleQuoteItemID ORDER BY OptionNo ASC
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04891', GetDate())
GO
