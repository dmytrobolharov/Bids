


CREATE VIEW [dbo].[vwx_StyleSourcing_QuoteCurrent_SEL]
AS
SELECT  b.StyleSourcingQuoteSchema,  a.* FROM pStyleQuoteItem a INNER JOIN pStyleCostingType b ON  a.StyleCostingType =  b.StyleCostingTypeID


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01159', GetDate())
GO

