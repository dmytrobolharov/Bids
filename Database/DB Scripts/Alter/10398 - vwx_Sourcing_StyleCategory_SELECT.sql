IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_StyleCategory_SELECT]'))
DROP VIEW [dbo].[vwx_Sourcing_StyleCategory_SELECT]
GO

CREATE VIEW [dbo].[vwx_Sourcing_StyleCategory_SELECT]
AS
SELECT TOP 100 PERCENT
	sc.StyleCategoryId
	, sc.StyleCategory
	, shsc.SourcingHeaderID
FROM pStyleCategory sc
	INNER JOIN pSourcingHeaderToStyleCategory shsc ON sc.StyleCategoryId = shsc.StyleCategoryID
WHERE Active = 1
ORDER BY StyleCategory

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10398', GetUTCDate())
GO
