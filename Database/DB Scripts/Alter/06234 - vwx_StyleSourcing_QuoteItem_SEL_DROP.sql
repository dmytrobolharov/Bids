IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_QuoteItem_SEL]'))
DROP VIEW [dbo].[vwx_StyleSourcing_QuoteItem_SEL]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06234', GetDate())
GO



