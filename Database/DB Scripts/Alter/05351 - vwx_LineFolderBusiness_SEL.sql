/****** Object:  View [dbo].[vwx_LineFolderBusiness_SEL]    Script Date: 03/19/2013 18:01:29 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderBusiness_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderBusiness_SEL]
GO

/****** Object:  View [dbo].[vwx_LineFolderBusiness_SEL]    Script Date: 03/19/2013 18:01:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LineFolderBusiness_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pLineFolderBusiness.LineFolderBusinessID, dbo.pLineFolderBusiness.LineFolderID, dbo.pLineFolderBusiness.LineFolderFinancialID, 
                      dbo.pLineFolderFinancial.LineFolderFinancialText, dbo.pLineFolderBusiness.LineFolderFinancialSort, dbo.pLineFolderBusiness.LineFolderDivisionID, 
                      dbo.pLineFolderBusiness.LineFolderStyleTypeID, dbo.pLineFolderBusiness.LineFolderStyleCategoryID, dbo.pLineFolderBusiness.LineFolderDivision, 
                      dbo.pLineFolderBusiness.LineFolderStyleTypeDescription, dbo.pLineFolderBusiness.LineFolderStyleCategory, dbo.pLineFolderBusiness.LineFolderDivisionSort, 
                      dbo.pLineFolderBusiness.LineFolderStyleTypeSort, dbo.pLineFolderBusiness.LineFolderStyleCategorySort, dbo.pLineFolderBusiness.LineFolderBusLYCh1, 
                      dbo.pLineFolderBusiness.LineFolderBusLYCh2, dbo.pLineFolderBusiness.LineFolderBusLYCh3, dbo.pLineFolderBusiness.LineFolderBusLYCh4, 
                      dbo.pLineFolderBusiness.LineFolderBusLYCh5, dbo.pLineFolderBusiness.LineFolderBusPnCh1, dbo.pLineFolderBusiness.LineFolderBusPnCh2, 
                      dbo.pLineFolderBusiness.LineFolderBusPnCh3, dbo.pLineFolderBusiness.LineFolderBusPnCh4, dbo.pLineFolderBusiness.LineFolderBusPnCh5, 
                      dbo.pLineFolderBusiness.LineFolderBusCuCh1, dbo.pLineFolderBusiness.LineFolderBusCuCh2, dbo.pLineFolderBusiness.LineFolderBusCuCh3, 
                      dbo.pLineFolderBusiness.LineFolderBusCuCh4, dbo.pLineFolderBusiness.LineFolderBusCuCh5, dbo.pLineFolderBusiness.LineFolderBus1, 
                      dbo.pLineFolderBusiness.LineFolderBus2, dbo.pLineFolderBusiness.LineFolderBus3, dbo.pLineFolderBusiness.LineFolderBus4, 
                      dbo.pLineFolderBusiness.LineFolderBus5, dbo.pLineFolderBusiness.LineFolderBus6, dbo.pLineFolderBusiness.LineFolderBus7, 
                      dbo.pLineFolderBusiness.LineFolderBus8, dbo.pLineFolderBusiness.LineFolderBus9, dbo.pLineFolderBusiness.LineFolderBus10, 
                      dbo.pLineFolderBusiness.LineFolderBus11, dbo.pLineFolderBusiness.LineFolderBus12, dbo.pLineFolderBusiness.LineFolderBus13, 
                      dbo.pLineFolderBusiness.LineFolderBus14, dbo.pLineFolderBusiness.LineFolderBus15, dbo.pLineFolderBusiness.LineFolderBus16, 
                      dbo.pLineFolderBusiness.LineFolderBus17, dbo.pLineFolderBusiness.LineFolderBus18, dbo.pLineFolderBusiness.LineFolderBus19, 
                      dbo.pLineFolderBusiness.LineFolderBus20, dbo.pLineFolderFinancial.LineFolderFinancialDataType, dbo.pLineFolderFinancial.LineFolderFinancialDataFormat, 
                      dbo.pLineFolderFinancial.LineFolderFinancialCssClass, dbo.pLineFolderBusiness.LineFolderBusWpCh1, dbo.pLineFolderBusiness.LineFolderBusWpCh2, 
                      dbo.pLineFolderBusiness.LineFolderBusWpCh3, dbo.pLineFolderBusiness.LineFolderBusWpCh4
FROM         dbo.pLineFolderBusiness INNER JOIN
                      dbo.pLineFolderFinancial ON dbo.pLineFolderBusiness.LineFolderFinancialID = dbo.pLineFolderFinancial.LineFolderFinancialID
ORDER BY dbo.pLineFolderBusiness.LineFolderFinancialSort

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05351', GetDate())
GO
