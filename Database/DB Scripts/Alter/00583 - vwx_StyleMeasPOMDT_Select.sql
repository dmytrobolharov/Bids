IF EXISTS(select * from INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_StyleMeasPOMDT_Select')
DROP VIEW vwx_StyleMeasPOMDT_Select
GO

CREATE VIEW vwx_StyleMeasPOMDT_Select
AS

SELECT  TOP (100) PERCENT pGRCompany.CompanyGuidID, pGRSizeClass.SizeClassGuidId, pGRSizeRange.SizeRangeGuidId, pGRGarment.GarmentGuidID,
		pGRSizeClassCompany.SizeClassCompanyId,   pGRGrmntClassImg.Garment_Cls_ImgGuidId, pGRClassRange.ClassRangeId, pGRPOMAlternates.POMAlternatesId,
		pGRPOMCompany.POMCompanyId, pGRAlternates.AlternatesGuidId, pGRPOM.POMGuidId, pGRTolerance.ToleranceGuidId, pGRGradeRule.GradeRuleGuidID,
		pGRCompany.Company, pGRSizeRange.SizeRange, pGRSizeClass.SizeClass, pGRGarment.Garment,  pGRPOM.RefCode, pGRPOM.POMDesc, pGRPOM.How2MeasName, 
		pGRPOM.How2MeasText, pGRPOM.VideoSerialNumber, pGRPOM.SortField, pGRPOM.CnvtPOMDesc, pGRPOM.ImageSerialNumber, pGRPOM.CUser, pGRPOM.CDate, 
		pGRPOM.Muser, pGRPOM.MDate, pGRAlternates.AlternatesCode, pGRAlternates.AlternatesDesc, pGRAlternates.GTSortField,   
		dbo.fnx_Frac2Num(pGRTolerance.TolPlus) AS TolPlus, dbo.fnx_Frac2Num(pGRTolerance.TolMinus) AS TolMinus, pGRTolerance.IsOnQA, pGRTolerance.IsPrimaryKeyMeas,  
		pGRGradeRule.Incr1, pGRGradeRule.Incr2, pGRGradeRule.Incr3, pGRGradeRule.Incr4, pGRGradeRule.Incr5, pGRGradeRule.Incr6, pGRGradeRule.Incr7, pGRGradeRule.Incr8, pGRGradeRule.Incr9, 
		pGRGradeRule.Incr10, pGRGradeRule.Incr11, pGRGradeRule.Incr12, pGRGradeRule.Incr13, pGRGradeRule.Incr14, pGRGradeRule.Incr15, pGRGradeRule.Incr16, 
		pGRGradeRule.Incr17, pGRGradeRule.Incr18, pGRGradeRule.Incr19, pGRGradeRule.Incr20, pGRGradeRule.Incr21, pGRGradeRule.Incr22, pGRGradeRule.Incr23, 
		pGRGradeRule.Incr24, pGRGradeRule.Incr25, pGRGradeRule.Incr26, pGRGradeRule.Incr27, pGRGradeRule.Incr28, pGRGradeRule.Incr29, pGRGradeRule.Incr30, 
		pGRGradeRule.Incr31, pGRGradeRule.Incr32, pGRGradeRule.Incr33, pGRGradeRule.Incr34, pGRGradeRule.Incr35, pGRGradeRule.Incr36, pGRGradeRule.Incr37, 
		pGRGradeRule.Incr38, pGRGradeRule.Incr39, pGRGradeRule.Incr40, pGRGradeRule.Incr41, pGRGradeRule.Incr42, pGRGradeRule.Incr43, pGRGradeRule.Incr44, 
		pGRGradeRule.Incr45, pGRGradeRule.Incr46, pGRGradeRule.Incr47, pGRGradeRule.Incr48,  
		pGRCompany.IsRelative, pGRCompany.IsNegative, pGRCompany.IsMetric, pGRCompany.IsActive
FROM pGRGradeRule INNER JOIN
      pGRSizeClass INNER JOIN
      pGRSizeClassCompany INNER JOIN
      pGRGarment INNER JOIN
      pGRPOMCompany INNER JOIN
      pGRPOM INNER JOIN
      pGRPOMAlternates ON pGRPOM.POMGuidId = pGRPOMAlternates.POMGuidId INNER JOIN
      pGRAlternates ON pGRPOMAlternates.AlternatesGuidId = pGRAlternates.AlternatesGuidId ON 
      pGRPOMCompany.POMAlternatesId = pGRPOMAlternates.POMAlternatesId INNER JOIN
      pGRCompany ON pGRPOMCompany.CompanyGuidID = pGRCompany.CompanyGuidID ON pGRGarment.CompanyGuidID = pGRCompany.CompanyGuidID ON 
      pGRSizeClassCompany.CompanyGuidId = pGRCompany.CompanyGuidID ON pGRSizeClass.SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId INNER JOIN
      pGRGrmntClassImg ON pGRGarment.GarmentGuidID = pGRGrmntClassImg.GarmentGuidID AND 
      pGRSizeClassCompany.SizeClassCompanyId = pGRGrmntClassImg.SizeClassCompanyId INNER JOIN
      pGRClassRange INNER JOIN
      pGRSizeRange ON pGRClassRange.SizeRangeGuidId = pGRSizeRange.SizeRangeGuidId ON 
      pGRSizeClass.SizeClassGuidId = pGRClassRange.SizeClassGuidId INNER JOIN
      pGRTolerance ON pGRPOMCompany.POMCompanyId = pGRTolerance.POMCompanyId AND 
      pGRGrmntClassImg.Garment_Cls_ImgGuidId = pGRTolerance.Garment_Cls_ImgGuidId ON pGRGradeRule.POMCompanyId = pGRPOMCompany.POMCompanyId AND 
      pGRGradeRule.ClassRangeId = pGRClassRange.ClassRangeId
ORDER BY pGRPOM.SortField, pGRAlternates.GTSortField, pGRPOM.RefCode, pGRAlternates.AlternatesCode
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '583', GetDate())
GO