/****** Object:  View [dbo].[vwx_MerchandiseTrackerBusiness_SEL]    Script Date: 07/10/2014 15:22:49 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MerchandiseTrackerBusiness_SEL]'))
DROP VIEW [dbo].[vwx_MerchandiseTrackerBusiness_SEL]
GO

/****** Object:  View [dbo].[vwx_MerchandiseTrackerBusiness_SEL]    Script Date: 07/10/2014 15:22:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_MerchandiseTrackerBusiness_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pLineFolderMerchandiseBusiness.PlanningBusinessID, dbo.pLineFolderMerchandiseBusiness.PlanningID, dbo.pLineFolderMerchandiseBusiness.PlanningFinancialID, 
                      dbo.pPlanningFinancial.PlanningFinancialText, dbo.pLineFolderMerchandiseBusiness.PlanningFinancialSort, dbo.pLineFolderMerchandiseBusiness.PlanningDivisionID, 
                      dbo.pLineFolderMerchandiseBusiness.PlanningStyleTypeID, dbo.pLineFolderMerchandiseBusiness.PlanningStyleCategoryID, dbo.pLineFolderMerchandiseBusiness.PlanningDivision, 
                      dbo.pLineFolderMerchandiseBusiness.PlanningStyleTypeDescription, dbo.pLineFolderMerchandiseBusiness.PlanningStyleCategory, dbo.pLineFolderMerchandiseBusiness.PlanningDivisionSort, 
                      dbo.pLineFolderMerchandiseBusiness.PlanningStyleTypeSort, dbo.pLineFolderMerchandiseBusiness.PlanningStyleCategorySort, 
                      dbo.pPlanningFinancial.PlanningFinancialDataType, dbo.pPlanningFinancial.PlanningFinancialDataFormat, dbo.pPlanningFinancial.PlanningFinancialCssClass, 
                      dbo.pLineFolderMerchandiseBusiness.PlanningPlanningCh, dbo.pLineFolderMerchandiseBusiness.PlanningLastYearCh, dbo.pLineFolderMerchandiseBusiness.PlanningDIPCh, 
                      dbo.pLineFolderMerchandiseBusiness.PlanningActualCh, dbo.pPlanningFinancial.Active, dbo.pLineFolderMerchandiseBusiness.PlanningBrandID, dbo.pLineFolderMerchandiseBusiness.PlanningBrand,
                      dbo.pLineFolderMerchandiseBusiness.PlanningSubCategoryID, dbo.pLineFolderMerchandiseBusiness.PlanningSubCategory,
                      dbo.pLineFolderMerchandiseBusiness.SeasonYearID, dbo.pLineFolderMerchandiseBusiness.LineFolderID
FROM         dbo.pLineFolderMerchandiseBusiness INNER JOIN
                      dbo.pPlanningFinancial ON dbo.pLineFolderMerchandiseBusiness.PlanningFinancialID = dbo.pPlanningFinancial.PlanningFinancialID
WHERE     (dbo.pPlanningFinancial.Active = 1)
ORDER BY dbo.pLineFolderMerchandiseBusiness.PlanningFinancialSort



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08277', GetDate())
GO                      