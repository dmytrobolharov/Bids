/****** Object:  View [dbo].[vwx_Samplerequest_TradePartner_StyleSeason_SEL]    Script Date: 02/11/2014 20:26:15 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Samplerequest_TradePartner_StyleSeason_SEL]'))
DROP VIEW [dbo].[vwx_Samplerequest_TradePartner_StyleSeason_SEL]
GO


/****** Object:  View [dbo].[vwx_Samplerequest_TradePartner_StyleSeason_SEL]    Script Date: 02/11/2014 20:26:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Samplerequest_TradePartner_StyleSeason_SEL]
AS
SELECT DISTINCT b.StyleSeasonYearID, s.Sort , s.StyleSeason + ' ' + s.StyleYear AS SeasonYear, s.SeasonYearID, TradePartnerRelationshipLevelID, b.StyleID
FROM pSampleRequestBOMTrade AS b INNER JOIN
 pStyleSeasonYear AS s ON b.StyleSeasonYearID = s.StyleSeasonYearID AND b.StyleID = s.StyleID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '07109', GetDate())
GO
