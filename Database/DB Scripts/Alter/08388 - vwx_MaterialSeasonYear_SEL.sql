/****** Object:  View [dbo].[vwx_MaterialSeasonYear_SEL]    Script Date: 7/22/2014 12:27:53 PM ******/
DROP VIEW [dbo].[vwx_MaterialSeasonYear_SEL]
GO

/****** Object:  View [dbo].[vwx_MaterialSeasonYear_SEL]    Script Date: 7/22/2014 12:27:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialSeasonYear_SEL]
AS
SELECT        a.MaterialSeasonYearID, a.SeasonYearID, a.MaterialID, b.Season, b.Year, b.Active, b.Sort
FROM            dbo.pMaterialSeasonYear AS a INNER JOIN
                         dbo.vwx_SeasonYear_SEL AS b ON a.SeasonYearID = b.SeasonYearID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08388', GetDate())
GO