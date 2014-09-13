SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(select * from INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_StyleMeasPOMDT_Select')
DROP VIEW vwx_StyleMeasPOMDT_Select
GO

CREATE VIEW vwx_StyleMeasPOMDT_Select
AS
SELECT     TOP (100) PERCENT pGRCompany.CompanyGuidID, pGRSizeClass.SizeClassGuidId, pGRSizeRange.SizeRangeGuidId, pGRGarment.GarmentGuidID, 
                      pGRGrmntClassImg.Garment_Cls_ImgGuidId, pGRPOMCompany.POMCompanyId, pGRPOM.POMGuidId, pGRPOMAlternates.POMAlternatesId, 
                      pGRPOMAlternates.AlternatesGuidId, pGRGradeRule.GradeRuleGuidID, pGRTolerance.ToleranceGuidId, pGRCompany.Company, pGRSizeClass.SizeClass, 
                      pGRSizeRange.SizeRange, pGRGarment.Garment, pGRPOM.RefCode, pGRPOM.POMDesc, pGRAlternates.AlternatesCode, pGRAlternates.AlternatesDesc, 
                      pGRAlternates.GTSortField, pGRPOM.How2MeasName, pGRPOM.How2MeasText, pGRPOM.VideoSerialNumber, pGRPOM.SortField, 
                      dbo.fnx_Frac2Num(pGRTolerance.TolPlus) AS TolPlus, dbo.fnx_Frac2Num(pGRTolerance.TolMinus) AS TolMinus, pGRTolerance.IsOnQA, pGRGradeRule.Incr1, 
                      pGRGradeRule.Incr2, pGRGradeRule.Incr3, pGRGradeRule.Incr4, pGRGradeRule.Incr5, pGRGradeRule.Incr6, pGRGradeRule.Incr7, pGRGradeRule.Incr8, 
                      pGRGradeRule.Incr9, pGRGradeRule.Incr10, pGRGradeRule.Incr11, pGRGradeRule.Incr12, pGRGradeRule.Incr13, pGRGradeRule.Incr14, pGRGradeRule.Incr15, 
                      pGRGradeRule.Incr16, pGRGradeRule.Incr17, pGRGradeRule.Incr18, pGRGradeRule.Incr19, pGRGradeRule.Incr20, pGRGradeRule.Incr21, pGRGradeRule.Incr22, 
                      pGRGradeRule.Incr23, pGRGradeRule.Incr24, pGRGradeRule.Incr25, pGRGradeRule.Incr26, pGRGradeRule.Incr27, pGRGradeRule.Incr28, pGRGradeRule.Incr29, 
                      pGRGradeRule.Incr30, pGRGradeRule.Incr32, pGRGradeRule.Incr33, pGRGradeRule.Incr31, pGRGradeRule.Incr34, pGRGradeRule.Incr35, pGRGradeRule.Incr36, 
                      pGRGradeRule.Incr37, pGRGradeRule.Incr38, pGRGradeRule.Incr39, pGRGradeRule.Incr40, pGRGradeRule.Incr41, pGRGradeRule.Incr42, pGRGradeRule.Incr43, 
                      pGRGradeRule.Incr44, pGRGradeRule.Incr45, pGRGradeRule.Incr46, pGRGradeRule.Incr47, pGRGradeRule.Incr48
FROM         pGRPOMCompany INNER JOIN
                      pGRClassRange INNER JOIN
                      pGRSizeClass ON pGRClassRange.SizeClassGuidId = pGRSizeClass.SizeClassGuidId INNER JOIN
                      pGRSizeClassCompany ON pGRSizeClass.SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId INNER JOIN
                      pGRCompany ON pGRSizeClassCompany.CompanyGuidId = pGRCompany.CompanyGuidID INNER JOIN
                      pGRSizeRange ON pGRClassRange.SizeRangeGuidId = pGRSizeRange.SizeRangeGuidId INNER JOIN
                      pGRGradeRule ON pGRSizeRange.SizeRangeGuidId = pGRGradeRule.SizeRangeGuidId AND pGRClassRange.SizeRangeGuidId = pGRGradeRule.SizeRangeGuidId ON
                       pGRPOMCompany.CompanyGuidID = pGRCompany.CompanyGuidID AND pGRPOMCompany.CompanyGuidID = pGRSizeClassCompany.CompanyGuidId AND 
                      pGRPOMCompany.POMCompanyId = pGRGradeRule.POMCompanyId INNER JOIN
                      pGRPOMAlternates INNER JOIN
                      pGRPOM ON pGRPOMAlternates.POMGuidId = pGRPOM.POMGuidId ON pGRPOMCompany.POMAlternatesId = pGRPOMAlternates.POMAlternatesId INNER JOIN
                      pGRAlternates ON pGRCompany.CompanyGuidID = pGRAlternates.CompanyGuidID AND pGRPOMCompany.CompanyGuidID = pGRAlternates.CompanyGuidID AND 
                      pGRPOMAlternates.AlternatesGuidId = pGRAlternates.AlternatesGuidId INNER JOIN
                      pGRGarment ON pGRCompany.CompanyGuidID = pGRGarment.CompanyGuidID AND pGRPOMCompany.CompanyGuidID = pGRGarment.CompanyGuidID AND 
                      pGRSizeClassCompany.CompanyGuidId = pGRGarment.CompanyGuidID AND pGRAlternates.CompanyGuidID = pGRGarment.CompanyGuidID INNER JOIN
                      pGRGrmntClassImg ON pGRSizeClass.SizeClassGuidId = pGRGrmntClassImg.SizeClassGuidId AND 
                      pGRGarment.GarmentGuidID = pGRGrmntClassImg.GarmentGuidID AND pGRClassRange.SizeClassGuidId = pGRGrmntClassImg.SizeClassGuidId INNER JOIN
                      pGRTolerance ON pGRGrmntClassImg.Garment_Cls_ImgGuidId = pGRTolerance.Garment_Cls_ImgGuidId AND 
                      pGRPOMCompany.POMCompanyId = pGRTolerance.POMCompanyId
ORDER BY pGRPOM.SortField, pGRAlternates.GTSortField, pGRPOM.RefCode, pGRAlternates.AlternatesCode
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '545', GetDate())
GO