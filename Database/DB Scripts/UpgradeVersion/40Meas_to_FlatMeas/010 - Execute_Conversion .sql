--
-- Flattened Measurements
--
EXEC wpx_pSizeClass_Yunify_IMPORT 'Yunify'
GO

EXEC wpx_pSizeRange_Yunify_IMPORT 'Yunify'
GO

EXEC wpx_pGRMeasurementsAlternates_Yunify_IMPORT 'Yunify'
GO

EXEC wpx_pGRMeasurementsClassRange_Yunify_IMPORT 'Yunify'
GO

EXEC wpx_pGRMeasurementsPOM_Yunify_IMPORT_new 'Yunify'
GO

EXEC wpx_pGRMeasurementsPOMAlternates_Yunify_IMPORT 'Yunify'
GO

EXEC wpx_pGRMeasurementsTempGroup_Yunify_IMPORT 'Yunify'
GO

EXEC wpx_Yunify_POMS_Cross_Ranges_UPDATE 'Yunify'
GO

update pGRMeasurementsPOMTemplateItem
set IsLinked = 1
where IsLinked = 0 or IsLinked is null
GO

update pGRMeasurementsPOMTemplateItem
set AlternatesCode = ''
where AlternatesCode = 'N'
and AlternatesDesc = 'None'
GO