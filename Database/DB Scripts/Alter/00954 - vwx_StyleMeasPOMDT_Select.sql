/****** Object:  View [dbo].[vwx_StyleMeasPOMDT_Select]    Script Date: 01/07/2011 09:17:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleMeasPOMDT_Select]'))
DROP VIEW [dbo].[vwx_StyleMeasPOMDT_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create VIEW [dbo].[vwx_StyleMeasPOMDT_Select]
AS


SELECT  TOP (100) PERCENT    pGRPOMCompany.POMCompanyId, pGRPOMCompany.CompanyGuidID, pGRPOMCompany.POMAlternatesId, pGRPOMCompany.RefCode, 
                      pGRPOMCompany.POMDesc, pGRPOMCompany.How2MeasName, pGRPOMCompany.How2MeasText, pGRPOMCompany.SortField, pGRPOMCompany.CnvtPOMDesc,
                      pGRPOMCompany.IsLinked, pGRPOMCompany.ImageId, pGRPOMCompany.CUser, pGRPOMCompany.CDate, pGRPOMCompany.MUser, pGRPOMCompany.MDate, 
                      pGRPOMAlternates.POMGuidId, pGRAlternates.AlternatesGuidId, pGRAlternates.AlternatesCode, pGRAlternates.AlternatesDesc, pGRAlternates.GTSortField, 
                      pGRClassRange.ClassRangeId, pGRClassRange.SizeRangeGuidId, pGRGradeRule.GradeRuleGuidID, pGRGradeRule.Incr1, pGRGradeRule.Incr2, 
                      pGRGradeRule.Incr3, pGRGradeRule.Incr4, pGRGradeRule.Incr5, pGRGradeRule.Incr6, pGRGradeRule.Incr7, pGRGradeRule.Incr8, pGRGradeRule.Incr9, 
                      pGRGradeRule.Incr10, pGRGradeRule.Incr11, pGRGradeRule.Incr12, pGRGradeRule.Incr13, pGRGradeRule.Incr14, pGRGradeRule.Incr15, pGRGradeRule.Incr16, 
                      pGRGradeRule.Incr17, pGRGradeRule.Incr18, pGRGradeRule.Incr19, pGRGradeRule.Incr20, pGRGradeRule.Incr21, pGRGradeRule.Incr22, pGRGradeRule.Incr23, 
                      pGRGradeRule.Incr24, pGRGradeRule.Incr25, pGRGradeRule.Incr26, pGRGradeRule.Incr27, pGRGradeRule.Incr28, pGRGradeRule.Incr29, pGRGradeRule.Incr30, 
                      pGRGradeRule.Incr31, pGRGradeRule.Incr32, pGRGradeRule.Incr33, pGRGradeRule.Incr34, pGRGradeRule.Incr35, pGRGradeRule.Incr36, pGRGradeRule.Incr37, 
                      pGRGradeRule.Incr38, pGRGradeRule.Incr39, pGRGradeRule.Incr40, pGRGradeRule.Incr41, pGRGradeRule.Incr42, pGRGradeRule.Incr43, pGRGradeRule.Incr44, 
                      pGRGradeRule.Incr45, pGRGradeRule.Incr46, pGRGradeRule.Incr47, pGRGradeRule.Incr48, pGRSizeClassCompany.SizeClass, 
                      pGRSizeClassCompany.SizeClassCompanyId, pGRSizeClassCompany.SizeClassGuidId, pGRTolerance.ToleranceGuidId, 
                      dbo.fnx_Frac2Num(pGRTolerance.TolPlus) AS TolPlus, dbo.fnx_Frac2Num(pGRTolerance.TolMinus) AS TolMinus, 
                      pGRTolerance.IsOnQA, pGRTolerance.IsPrimaryKeyMeas, pGRProductCompany.Product, pGRTolerance.ProductClassImageId, 
                      pGRProductClassImage.ProductCompanyId
FROM   pGRTolerance INNER JOIN
                      pGRProductClassImage ON pGRTolerance.ProductClassImageId = pGRProductClassImage.ProductClassImageID INNER JOIN
                      pGRProductCompany ON pGRProductClassImage.ProductCompanyId = pGRProductCompany.ProductCompanyId INNER JOIN
                      pGRSizeClassCompany ON pGRProductClassImage.SizeClassCompanyId = pGRSizeClassCompany.SizeClassCompanyId INNER JOIN
                      pGRGradeRule INNER JOIN
                      pGRClassRange ON pGRGradeRule.ClassRangeId = pGRClassRange.ClassRangeId INNER JOIN
                      pGRPOM INNER JOIN
                      pGRAlternates INNER JOIN
                      pGRPOMCompany INNER JOIN
                      pGRPOMAlternates ON pGRPOMCompany.POMAlternatesId = pGRPOMAlternates.POMAlternatesId ON 
                      pGRAlternates.AlternatesGuidId = pGRPOMAlternates.AlternatesGuidId ON pGRPOM.POMGuidId = pGRPOMAlternates.POMGuidId ON 
                      pGRGradeRule.POMCompanyId = pGRPOMCompany.POMCompanyId ON pGRTolerance.POMCompanyId = pGRPOMCompany.POMCompanyId
                      ORDER BY pGRPOMCompany.SortField, pGRAlternates.GTSortField, pGRPOMCompany.RefCode, pGRAlternates.AlternatesCode
                      
                      


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '954', GetDate())
GO