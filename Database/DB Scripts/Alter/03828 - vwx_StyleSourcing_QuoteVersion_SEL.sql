IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_QuoteVersion_SEL]'))
DROP VIEW [dbo].[vwx_StyleSourcing_QuoteVersion_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleSourcing_QuoteVersion_SEL]
AS
SELECT  b.StyleSourcingQuoteSchema,  a.* FROM pStyleQuoteItemVersion a INNER JOIN pStyleCostingType b ON  a.StyleCostingType =  b.StyleCostingTypeID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03828', GetDate())
GO
