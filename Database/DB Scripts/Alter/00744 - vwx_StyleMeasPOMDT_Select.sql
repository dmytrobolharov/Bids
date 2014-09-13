/****** Object:  View [dbo].[vwx_StyleMeasPOMDT_Select]    Script Date: 11/18/2010 12:16:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOM' and COLUMN_NAME = N'ImageId')
       BEGIN 
            ALTER TABLE pGRPOM ADD ImageId UniqueIdentifier Null
       END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleMeasPOMDT_Select]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_StyleMeasPOMDT_Select]
GO

Create VIEW [dbo].[vwx_StyleMeasPOMDT_Select]
AS

SELECT   TOP (100) PERCENT  pGRPOMCompany.POMCompanyId, pGRPOM.POMGuidId, pGRAlternates.AlternatesGuidId, pGRAlternates.AlternatesCode, pGRAlternates.AlternatesDesc, pGRAlternates.GTSortField, pGRPOM.RefCode, 
                      pGRPOM.POMDesc, pGRPOM.How2MeasName, pGRPOM.How2MeasText, pGRPOM.SortField, pGRPOM.Imageid, pGRPOM.MDate, pGRPOM.Muser, pGRPOM.CDate, 
                      pGRPOM.CUser, pGRPOMAlternates.POMAlternatesId, pGRCompany.CompanyGuidID, pGRCompany.Company, pGRCompany.IsRelative, pGRCompany.IsNegative, 
                      pGRCompany.IsMetric, pGRCompany.IsActive, pGRCompany.ClassifierId, pGRSizeClass.SizeClassGuidId, 
                      pGRSizeClass.SizeClass, pGRSizeRange.SizeRangeGuidId, pGRSizeRange.SizeRange, pGRSizeClassCompany.SizeClassCompanyId, 
                      pGRClassRange.ClassRangeId, pGRGradeRule.GradeRuleGuidID, pGRGradeRule.Incr1, pGRGradeRule.Incr2, pGRGradeRule.Incr3, pGRGradeRule.Incr4, 
                      pGRGradeRule.Incr5, pGRGradeRule.Incr6, pGRGradeRule.Incr7, pGRGradeRule.Incr8, pGRGradeRule.Incr9, pGRGradeRule.Incr10, pGRGradeRule.Incr11, 
                      pGRGradeRule.Incr12, pGRGradeRule.Incr13, pGRGradeRule.Incr14, pGRGradeRule.Incr15, pGRGradeRule.Incr16, pGRGradeRule.Incr17, pGRGradeRule.Incr18, 
                      pGRGradeRule.Incr19, pGRGradeRule.Incr20, pGRGradeRule.Incr21, pGRGradeRule.Incr22, pGRGradeRule.Incr23, pGRGradeRule.Incr24, pGRGradeRule.Incr25, 
                      pGRGradeRule.Incr26, pGRGradeRule.Incr27, pGRGradeRule.Incr28, pGRGradeRule.Incr29, pGRGradeRule.Incr30, pGRGradeRule.Incr31, pGRGradeRule.Incr32, 
                      pGRGradeRule.Incr33, pGRGradeRule.Incr34, pGRGradeRule.Incr35, pGRGradeRule.Incr36, pGRGradeRule.Incr37, pGRGradeRule.Incr38, pGRGradeRule.Incr39, 
                      pGRGradeRule.Incr40, pGRGradeRule.Incr41, pGRGradeRule.Incr42, pGRGradeRule.Incr43, pGRGradeRule.Incr44, pGRGradeRule.Incr45, pGRGradeRule.Incr46, 
                      pGRGradeRule.Incr47, pGRGradeRule.Incr48, pGRProduct.ProductID, pGRProduct.Product, pGRProductCompany.ProductCompanyId, 
                      pGRProductClassImage.ProductClassImageID, pGRTolerance.ToleranceGuidId, dbo.fnx_Frac2Num(pGRTolerance.TolPlus) AS TolPlus, dbo.fnx_Frac2Num(pGRTolerance.TolMinus) AS TolMinus, pGRTolerance.IsOnQA, 
                      pGRTolerance.IsPrimaryKeyMeas
FROM         pGRProductCompany INNER JOIN
                      pGRProduct ON pGRProductCompany.ProductId = pGRProduct.ProductID INNER JOIN
                      pGRGradeRule INNER JOIN
                      pGRPOM INNER JOIN
                      pGRAlternates INNER JOIN
                      pGRPOMAlternates ON pGRAlternates.AlternatesGuidId = pGRPOMAlternates.AlternatesGuidId ON pGRPOM.POMGuidId = pGRPOMAlternates.POMGuidId INNER JOIN
                      pGRPOMCompany INNER JOIN
                      pGRCompany ON pGRPOMCompany.CompanyGuidID = pGRCompany.CompanyGuidID ON 
                      pGRPOMAlternates.POMAlternatesId = pGRPOMCompany.POMAlternatesId INNER JOIN
                      pGRSizeClassCompany ON pGRCompany.CompanyGuidID = pGRSizeClassCompany.CompanyGuidId INNER JOIN
                      pGRSizeClass ON pGRSizeClassCompany.SizeClassGuidId = pGRSizeClass.SizeClassGuidId INNER JOIN
                      pGRSizeRange INNER JOIN
                      pGRClassRange ON pGRSizeRange.SizeRangeGuidId = pGRClassRange.SizeRangeGuidId ON 
                      pGRSizeClassCompany.SizeClassCompanyId = pGRClassRange.SizeClassCompanyid ON pGRGradeRule.POMCompanyId = pGRPOMCompany.POMCompanyId AND 
                      pGRGradeRule.ClassRangeId = pGRClassRange.ClassRangeId ON pGRProductCompany.CompanyGuidId = pGRCompany.CompanyGuidID INNER JOIN
                      pGRProductClassImage ON pGRProductCompany.ProductCompanyId = pGRProductClassImage.ProductCompanyId AND 
                      pGRSizeClassCompany.SizeClassCompanyId = pGRProductClassImage.SizeClassCompanyId INNER JOIN
                      pGRTolerance ON pGRProductClassImage.ProductClassImageID = pGRTolerance.ProductClassImageId AND 
                      pGRPOMCompany.POMCompanyId = pGRTolerance.POMCompanyId
ORDER BY pGRPOM.SortField, pGRAlternates.GTSortField, pGRPOM.RefCode, pGRAlternates.AlternatesCode

Go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '744', GetDate())
GO