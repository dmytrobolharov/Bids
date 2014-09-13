IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_UnFlattenedPOMS')
   BEGIN
            DROP VIEW vwx_UnFlattenedPOMS
   END
GO

CREATE VIEW vwx_UnFlattenedPOMS 
       AS 
       SELECT POMTempItemID
             ,POMTempGroupID
             ,POMTempID
             , CASE WHEN charindex('.', pomcode) = 0 THEN pomcode 
                   ELSE SUBSTRING(POMCode, 1, charindex('.', pomcode) - 1) END AS REFCODE
       FROM pGRMeasurementsPOMTemplateItem
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_sizerange1')
   BEGIN
            DROP VIEW vwx_sizerange1
   END
GO

CREATE VIEW vwx_sizerange1
       AS 
       select  distinct p1.SizeClassGuidId , pgd.SizeRangeId
         from pGRClassRange p1 , pGRSizeRangeDetail pgd
        where p1.ClassRangeId =pgd.ClassRangeId
GO

