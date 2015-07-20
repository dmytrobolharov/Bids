IF OBJECT_ID(N'[dbo].[vwx_ConsumptionLabor_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_ConsumptionLabor_SELECT]
GO

CREATE VIEW [dbo].[vwx_ConsumptionLabor_SELECT]
AS
SELECT cl.ConsumptionLaborTablesID, cl.SizeClass, cl.StyleCategoryID, cl.ConsumptionRatios, 
       cl.LaborCosts, cl.MUser, cl.MDate, sc.StyleCategory AS CategoryName
FROM  dbo.sConsumptionLabor AS cl 
LEFT JOIN dbo.pStyleCategory AS sc ON sc.StyleCategoryId = cl.StyleCategoryID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09419', GetDate())
GO
