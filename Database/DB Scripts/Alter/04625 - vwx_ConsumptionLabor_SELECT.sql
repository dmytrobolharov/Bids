IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ConsumptionLabor_SELECT]'))
DROP VIEW [dbo].[vwx_ConsumptionLabor_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ConsumptionLabor_SELECT]
AS
SELECT     cl.ConsumptionLaborTablesID, cl.SizeClass, cl.StyleCategoryID, cl.ConsumptionRatios, cl.LaborCosts, cl.MUser, cl.MDate, sc.StyleCategory AS CategoryName
FROM         dbo.sConsumptionLabor AS cl LEFT OUTER JOIN
                      dbo.pStyleCategory AS sc ON sc.StyleCategoryId = cl.StyleCategoryID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04625', GetDate())
GO
