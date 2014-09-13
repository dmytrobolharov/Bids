IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleTechPack_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleTechPack_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleTechPack_INSERT] 
(
	@StyleQuoteItemID uniqueidentifier,
	@TechPackID uniqueidentifier
)
AS
BEGIN
	UPDATE pStyleQuoteItem SET TechPack = @TechPackID WHERE StyleQuoteItemID = @StyleQuoteItemID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06743', GetDate())
GO
