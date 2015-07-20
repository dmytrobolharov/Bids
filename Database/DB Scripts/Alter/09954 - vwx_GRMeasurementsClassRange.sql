IF OBJECT_ID(N'[dbo].[vwx_GRMeasurementsClassRange]') IS NOT NULL
 DROP VIEW [dbo].[vwx_GRMeasurementsClassRange]
GO

CREATE VIEW vwx_GRMeasurementsClassRange 
AS
SELECT mcr.ClassRangeId, sc.Custom + ' (' + sr.SizeRangeCode + ')' AS ClassRange, 
	   mcr.SizeClassId, sc.Custom AS SizeClass,  
       mcr.SizeRangeId, sr.SizeRangeCode AS SizeRange,
	   mcr.Active 
FROM pGRMeasurementsClassRange mcr
LEFT JOIN pSizeClass sc ON sc.CustomID = mcr.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = mcr.SizeRangeId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09954', GetUTCDate())
GO
