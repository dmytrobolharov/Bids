/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_BOMOption_SELECT]    Script Date: 11/20/2012 18:22:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_BOMOption_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_BOMOption_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_BOMOption_SELECT]    Script Date: 11/20/2012 18:22:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleQuote_BOMOption_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM pSourcingQuotationBOMOption WHERE StyleQuoteItemID = @StyleQuoteItemID ORDER BY OptionNo ASC
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04432', GetDate())
GO

