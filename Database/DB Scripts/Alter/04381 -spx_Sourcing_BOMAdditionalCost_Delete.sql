

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_BOMAdditionalCost_Delete]    Script Date: 11/19/2012 16:23:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_BOMAdditionalCost_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_BOMAdditionalCost_Delete]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_BOMAdditionalCost_Delete]    Script Date: 11/19/2012 16:23:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_Sourcing_BOMAdditionalCost_Delete]
(
@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier
)
AS 
begin
Declare @iCnt int
select @iCnt=COUNT(StyleQuoteItemID) from pStyleQuoteItem WHERE StyleQuoteItemID = @QuoteItemID	
and SourcingHeaderID=@SourcingHeaderID

if @iCnt=0
begin
	delete from pSourcingQuoteStyleBOM where StyleQuoteItemID = @QuoteItemID and SourcingHeaderID=@SourcingHeaderID
	delete from pSourcingQuotationBOMDetails where StyleQuoteItemID = @QuoteItemID and SourcingHeaderID=@SourcingHeaderID
	delete from pSourcingAdditionalCost where QuoteItemID = @QuoteItemID and SourcingHeaderID=@SourcingHeaderID
	
	
end

end

GO










INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04381', GetDate())
GO
