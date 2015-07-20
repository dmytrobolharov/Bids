/****** Object:  View [dbo].[vwx_BatchQPage_DimensionalBOM_SEL]    Script Date: 12/06/2012 13:55:11 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQPage_DimensionalBOM_SEL]'))
DROP VIEW [dbo].[vwx_BatchQPage_DimensionalBOM_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQPage_DimensionalBOM_SEL]    Script Date: 12/06/2012 13:55:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQPage_DimensionalBOM_SEL]
AS
SELECT     dbo.pStyleBOMDimension.StyleBOMDimensionID, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemName, 
                      dbo.pStyleHeader.StyleType, dbo.pStyleHeader.Description, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, 
                      dbo.pStyleHeader.StyleSet, dbo.pStyleHeader.TechPackId, dbo.pStyleHeader.TechPackDate, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, 
                      dbo.pStyleHeader.MaterialID, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.MaterialImageVersion, dbo.pStyleHeader.MaterialNo, 
                      dbo.pStyleHeader.MaterialName, dbo.pStyleHeader.StyleMaterialID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ConceptSketchID, dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.TradePartnerVendorID, 
                      dbo.pStyleHeader.IntroSeasonYearID, dbo.pStyleHeader.PlannedDueDate, dbo.pStyleHeader.PlannedStartDate, dbo.pStyleHeader.StartDate, 
                      dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, dbo.pStyleHeader.CustomField34, 
                      dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, dbo.pStyleHeader.CustomField38, 
                      dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40, dbo.pStyleHeader.CustomField30, dbo.pStyleHeader.CustomField29, 
                      dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField26, dbo.pStyleHeader.CustomField25, 
                      dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField22, dbo.pStyleHeader.CustomField21, 
                      dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField18, dbo.pStyleHeader.CustomField17, 
                      dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.Active, dbo.pStyleHeader.CUser, dbo.pStyleHeader.CDate, dbo.pStyleHeader.MDate, dbo.pStyleHeader.MUser, 
                      dbo.pStyleHeader.CustomField15, dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, 
                      dbo.pStyleHeader.CustomField11, dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField8, 
                      dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField5, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField3,
                       dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.StyleNo
FROM         dbo.pStyleBOMDimension LEFT OUTER JOIN
                      dbo.pWorkFlowItem ON dbo.pStyleBOMDimension.WorkFlowItemID = dbo.pWorkFlowItem.WorkFlowItemID INNER JOIN
                      dbo.pStyleHeader ON dbo.pWorkFlowItem.StyleID = dbo.pStyleHeader.StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04573', GetDate())
GO
