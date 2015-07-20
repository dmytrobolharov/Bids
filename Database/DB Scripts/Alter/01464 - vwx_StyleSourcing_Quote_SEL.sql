

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_Quote_SEL]'))
DROP VIEW [dbo].[vwx_StyleSourcing_Quote_SEL]
GO

/****** Object:  View [dbo].[vwx_StyleSourcing_Quote_SEL]    Script Date: 02/04/2011 00:21:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleSourcing_Quote_SEL]
AS
select a.*,  b.StyleNo, b.SizeClass, b.MaterialNo,
 c.Margin, c.TotalLandCost, b.Pc1, d.StyleColorName,
 y.SeasonYearID, y.StyleSeason + ' ' + y.StyleYear AS StyleSeasonYear
  
 from   dbo.pStyleQuoteItemFreightCost  c RIGHT  OUTER JOIN 
dbo.pStyleQuoteItem  a ON  c.StyleQuoteItemId = a.StyleQuoteItemID
INNER JOIN dbo.pStyleHeader  b ON a.StyleID = b.StyleID
LEFT  OUTER JOIN dbo.pStyleColorway d ON a.StyleColorID = d.StyleColorID
LEFT  OUTER JOIN dbo.pStyleSourcing s ON a.StyleSourcingID = s.StyleSourcingID 
LEFT  OUTER JOIN dbo.pStyleSeasonYear y ON s.StyleSeasonYearID = y.StyleSeasonYearID

WHERE a.StyleQuoteItemShare=1


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01464', GetDate())

GO
