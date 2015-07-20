/****** Object:  View [dbo].[vwx_StyleMeasPOMDT_Select]    Script Date: 09/20/2010 08:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CREATE VIEW [dbo].[vwx_StyleMeasPOMDT_Select]
--AS
--SELECT     TOP (100) PERCENT dbo.pGRCompany.CompanyGuidID, dbo.pGRSizeClass.SizeClassGuidId, dbo.pGRSizeRange.SizeRangeGuidId, 
--                      dbo.pGRGarment.GarmentGuidID, dbo.pGRGrmntClassImg.Garment_Cls_ImgGuidId, dbo.pGRPOMCompany.POMCompanyId, dbo.pGRPOM.POMGuidId, 
--                      dbo.pGRPOMAlternates.POMAlternatesId, dbo.pGRPOMAlternates.AlternatesGuidId, dbo.pGRGradeRule.GradeRuleGuidID, dbo.pGRTolerance.ToleranceGuidId, 
--                      dbo.pGRCompany.Company, dbo.pGRSizeClass.SizeClass, dbo.pGRSizeRange.SizeRange, dbo.pGRGarment.Garment, dbo.pGRPOM.RefCode, 
--                      dbo.pGRPOM.POMDesc, dbo.pGRAlternates.AlternatesCode, dbo.pGRAlternates.AlternatesDesc, dbo.pGRAlternates.GTSortField, dbo.pGRPOM.How2MeasName, 
--                      dbo.pGRPOM.How2MeasText, dbo.pGRPOM.VideoSerialNumber, dbo.pGRPOM.SortField, dbo.fnx_Frac2Num(dbo.pGRTolerance.TolPlus) AS TolPlus, 
--                      dbo.fnx_Frac2Num(dbo.pGRTolerance.TolMinus) AS TolMinus, dbo.pGRTolerance.IsOnQA, dbo.pGRGradeRule.Incr1, dbo.pGRGradeRule.Incr2, 
--                      dbo.pGRGradeRule.Incr3, dbo.pGRGradeRule.Incr4, dbo.pGRGradeRule.Incr5, dbo.pGRGradeRule.Incr6, dbo.pGRGradeRule.Incr7, dbo.pGRGradeRule.Incr8, 
--                      dbo.pGRGradeRule.Incr9, dbo.pGRGradeRule.Incr10, dbo.pGRGradeRule.Incr11, dbo.pGRGradeRule.Incr12, dbo.pGRGradeRule.Incr13, dbo.pGRGradeRule.Incr14, 
--                      dbo.pGRGradeRule.Incr15, dbo.pGRGradeRule.Incr16, dbo.pGRGradeRule.Incr17, dbo.pGRGradeRule.Incr18, dbo.pGRGradeRule.Incr19, dbo.pGRGradeRule.Incr20, 
--                      dbo.pGRGradeRule.Incr21, dbo.pGRGradeRule.Incr22, dbo.pGRGradeRule.Incr23, dbo.pGRGradeRule.Incr24, dbo.pGRGradeRule.Incr25, dbo.pGRGradeRule.Incr26, 
--                      dbo.pGRGradeRule.Incr27, dbo.pGRGradeRule.Incr28, dbo.pGRGradeRule.Incr29, dbo.pGRGradeRule.Incr30, dbo.pGRGradeRule.Incr32, dbo.pGRGradeRule.Incr33, 
--                      dbo.pGRGradeRule.Incr31, dbo.pGRGradeRule.Incr34, dbo.pGRGradeRule.Incr35, dbo.pGRGradeRule.Incr36, dbo.pGRGradeRule.Incr37, dbo.pGRGradeRule.Incr38, 
--                      dbo.pGRGradeRule.Incr39, dbo.pGRGradeRule.Incr40, dbo.pGRGradeRule.Incr41, dbo.pGRGradeRule.Incr42, dbo.pGRGradeRule.Incr43, dbo.pGRGradeRule.Incr44, 
--                      dbo.pGRGradeRule.Incr45, dbo.pGRGradeRule.Incr46, dbo.pGRGradeRule.Incr47, dbo.pGRGradeRule.Incr48
-- FROM         dbo.pGRClassRange INNER JOIN
--                      dbo.pGRSizeClass ON dbo.pGRClassRange.SizeClassGuidId = dbo.pGRSizeClass.SizeClassGuidId INNER JOIN
--                      dbo.pGRSizeClassCompany ON dbo.pGRSizeClass.SizeClassGuidId = dbo.pGRSizeClassCompany.SizeClassGuidId INNER JOIN
--                      dbo.pGRCompany ON dbo.pGRSizeClassCompany.CompanyGuidId = dbo.pGRCompany.CompanyGuidID INNER JOIN
--                      dbo.pGRSizeRange ON dbo.pGRClassRange.SizeRangeGuidId = dbo.pGRSizeRange.SizeRangeGuidId INNER JOIN
--                      dbo.pGRGradeRule ON dbo.pGRSizeRange.SizeRangeGuidId = dbo.pGRGradeRule.SizeRangeGuidId AND 
--                      dbo.pGRClassRange.SizeRangeGuidId = dbo.pGRGradeRule.SizeRangeGuidId INNER JOIN
--                      dbo.pGRPOM ON dbo.pGRCompany.CompanyGuidID = dbo.pGRPOM.CompanyGuidId INNER JOIN
--                      dbo.pGRPOMAlternates ON dbo.pGRGradeRule.POMAlternatesId = dbo.pGRPOMAlternates.POMAlternatesId AND 
--                      dbo.pGRPOM.POMGuidId = dbo.pGRPOMAlternates.POMGuidId INNER JOIN
--                      dbo.pGRPOMCompany ON dbo.pGRCompany.CompanyGuidID = dbo.pGRPOMCompany.CompanyGuidID AND 
--                      dbo.pGRPOMAlternates.POMAlternatesId = dbo.pGRPOMCompany.POMAlternatesId AND 
--                      dbo.pGRSizeClassCompany.CompanyGuidId = dbo.pGRPOMCompany.CompanyGuidID INNER JOIN
--                      dbo.pGRAlternates ON dbo.pGRCompany.CompanyGuidID = dbo.pGRAlternates.CompanyGuidID AND 
--                      dbo.pGRPOMCompany.CompanyGuidID = dbo.pGRAlternates.CompanyGuidID AND 
--                      dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId INNER JOIN
--                      dbo.pGRGarment ON dbo.pGRCompany.CompanyGuidID = dbo.pGRGarment.CompanyGuidID AND 
--                      dbo.pGRPOMCompany.CompanyGuidID = dbo.pGRGarment.CompanyGuidID AND dbo.pGRSizeClassCompany.CompanyGuidId = dbo.pGRGarment.CompanyGuidID AND
--                       dbo.pGRAlternates.CompanyGuidID = dbo.pGRGarment.CompanyGuidID INNER JOIN
--                      dbo.pGRGrmntClassImg ON dbo.pGRSizeClass.SizeClassGuidId = dbo.pGRGrmntClassImg.SizeClassGuidId AND 
--                      dbo.pGRGarment.GarmentGuidID = dbo.pGRGrmntClassImg.GarmentGuidID AND 
--                      dbo.pGRClassRange.SizeClassGuidId = dbo.pGRGrmntClassImg.SizeClassGuidId INNER JOIN
--                     dbo.pGRTolerance ON dbo.pGRPOMAlternates.POMAlternatesId = dbo.pGRTolerance.POMAlternatesId AND 
--                      dbo.pGRGrmntClassImg.Garment_Cls_ImgGuidId = dbo.pGRTolerance.Garment_Cls_ImgGuidId AND 
--                      dbo.pGRPOMCompany.POMAlternatesId = dbo.pGRTolerance.POMAlternatesId
--ORDER BY dbo.pGRPOM.SortField, dbo.pGRAlternates.GTSortField, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode
--
--GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '412', GetDate())
GO