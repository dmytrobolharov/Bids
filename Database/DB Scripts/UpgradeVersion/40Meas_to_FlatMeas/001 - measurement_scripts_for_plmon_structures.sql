/*
truncate table pGRAlternates
truncate table pGRClassRange
truncate table pGRCompany
truncate table pGRGradeRule
truncate table pGRGradeRuleDetail
truncate table pGRGradeType
truncate table pGRKeyMeasurement
truncate table pGRPOM
truncate table pGRPOMAlternates
truncate table pGRPOMCompany
truncate table pGRPOMGradeType
truncate table pGRProduct
truncate table pGRProductClassImage
truncate table pGRProductCompany
truncate table pGRSizeClass
truncate table pGRSizeClassCompany
truncate table pGRSizeRange
truncate table pGRSizeRangeDetail
truncate table pGRTolerance

truncate table pGRMeasurementsAlternates
truncate table pGRMeasurementsClassRange
truncate table pGRMeasurementsPOM
truncate table pGRMeasurementsPOMAlternates
truncate table pGRMeasurementsPOMTemplate
truncate table pGRMeasurementsPOMTemplateGroup
truncate table pGRMeasurementsPOMTemplateItem

delete from pSizeClass where CUser = 'yunify'
delete from pSizeRange where CUser = 'yunify'

delete from icustom1 
where cuser = 'yunify'

go
*/




IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartner'
and COLUMN_NAME = N'TradePartnerCode'
and CHARACTER_MAXIMUM_LENGTH = 25 )
BEGIN
      ALTER TABLE uTradePartner ALTER COLUMN TradePartnerCode NVARCHAR(25) NULL
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02235'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02235', GetDate())
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartnerVendor'
and COLUMN_NAME = N'VendorCode'
and CHARACTER_MAXIMUM_LENGTH = 25 )
BEGIN
      ALTER TABLE uTradePartnerVendor ALTER COLUMN VendorCode NVARCHAR(25) NULL
END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02260'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02260', GetDate())
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartnerContact'
and COLUMN_NAME = N'PhoneNumber'
and CHARACTER_MAXIMUM_LENGTH = 50 )
BEGIN
      ALTER TABLE uTradePartnerContact ALTER COLUMN PhoneNumber NVARCHAR(50) NULL
END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02261'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02261', GetDate())
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartnerVendorContact'
and COLUMN_NAME = N'PhoneNumber'
and CHARACTER_MAXIMUM_LENGTH = 50 )
BEGIN
      ALTER TABLE uTradePartnerVendorContact ALTER COLUMN PhoneNumber NVARCHAR(50) NULL
END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02262'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02262', GetDate())
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeClass'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
      ALTER TABLE pGRSizeClass ADD FlatSizeClassId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeRange'
and COLUMN_NAME = N'FlatSizeRangeId' )
BEGIN 
      ALTER TABLE pGRSizeRange ADD FlatSizeRangeId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeRange'
and COLUMN_NAME = N'FinalSizeRangeId' )
BEGIN 
      ALTER TABLE pGRSizeRange ADD FinalSizeRangeId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeRange'
and COLUMN_NAME = N'XFER2SizeRange' )
BEGIN 
      ALTER TABLE pGRSizeRange ADD XFER2SizeRange int null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeRangeDetail'
and COLUMN_NAME = N'FinalSizeRangeId' )
BEGIN 
      ALTER TABLE pGRSizeRangeDetail ADD FinalSizeRangeId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeRangeDetail'
and COLUMN_NAME = N'XFER2SizeRange' )
BEGIN 
      ALTER TABLE pGRSizeRangeDetail ADD XFER2SizeRange int null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeRange'
and COLUMN_NAME = N'IsClassRange0' )
BEGIN 
      ALTER TABLE pGRSizeRange ADD IsClassRange0 int null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRClassRange'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
      ALTER TABLE pGRClassRange ADD FlatSizeClassId uniqueidentifier null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRClassRange'
and COLUMN_NAME = N'FlatSizeRangeId' )
BEGIN 
      ALTER TABLE pGRClassRange ADD FlatSizeRangeId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRClassRange'
and COLUMN_NAME = N'FlatClassRangeId' )
BEGIN 
      ALTER TABLE pGRClassRange ADD FlatClassRangeId uniqueidentifier null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRClassRange'
and COLUMN_NAME = N'XFER2Flat' )
BEGIN 
      ALTER TABLE pGRClassRange ADD XFER2Flat int null
END
GO



IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOM'
and COLUMN_NAME = N'FlatPOMId' )
BEGIN 
      ALTER TABLE pGRPOM ADD FlatPOMId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOM'
and COLUMN_NAME = N'FlatRefCode' )
BEGIN 
      ALTER TABLE pGRPOM ADD FlatRefCode nvarchar(12) null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOM'
and COLUMN_NAME = N'IsLibPOM' )
BEGIN 
      ALTER TABLE pGRPOM ADD IsLibPOM int null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOM'
and COLUMN_NAME = N'XferPOM' )
BEGIN 
      ALTER TABLE pGRPOM ADD XferPOM int null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeClassCompany'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
      ALTER TABLE pGRSizeClassCompany ADD FlatSizeClassId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeClassCompany'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
      ALTER TABLE pGRSizeClassCompany ADD FlatSizeClassId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRSizeClassCompany'
and COLUMN_NAME = N'Company' )
BEGIN 
      ALTER TABLE pGRSizeClassCompany ADD Company    [nvarchar](60) null
      ALTER TABLE pGRSizeClassCompany ADD IsRelative [int] null
      ALTER TABLE pGRSizeClassCompany ADD IsNegative [int] null
      ALTER TABLE pGRSizeClassCompany ADD IsMetric   [int] null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRGradeRule'
and COLUMN_NAME = N'FlatClassRangeId' )
BEGIN 
      ALTER TABLE pGRGradeRule ADD FlatClassRangeId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRGradeRule'
and COLUMN_NAME = N'XFER2Flat' )
BEGIN 
      ALTER TABLE pGRGradeRule ADD XFER2Flat int null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRGradeRule'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
      ALTER TABLE pGRGradeRule ADD FlatSizeClassId uniqueidentifier null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRGradeRule'
and COLUMN_NAME = N'FlatSizeRangeId' )
BEGIN 
      ALTER TABLE pGRGradeRule ADD FlatSizeRangeId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOMCompany'
and COLUMN_NAME = N'XferPOM' )
BEGIN 
      ALTER TABLE pGRPOMCompany ADD XferPOM int null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRProductCompany'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
     ALTER TABLE pGRProductCompany ADD Company nvarchar(100) null
END
GO



--IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRProductCompany'
--and COLUMN_NAME = N'FlatSizeClassId' )
--BEGIN 
--      ALTER TABLE pGRProductCompany ADD POMTempGroupid uniqueidentifier null
--END
--GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRProductClassImage'
and COLUMN_NAME = N'FlatSizeClassId' )
BEGIN 
      ALTER TABLE pGRProductClassImage ADD FlatSizeClassId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOMAlternates'
and COLUMN_NAME = N'FlatPOMId' )
BEGIN 
      ALTER TABLE pGRPOMAlternates ADD FlatPOMId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRAlternates'
and COLUMN_NAME = N'MapAlternatesId' )
BEGIN 
     alter table pGRAlternates ADD MapAlternatesId uniqueidentifier null
END
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOMAlternates'
and COLUMN_NAME = N'MapAlternatesId' )
BEGIN 
     alter table pGRPOMAlternates ADD MapAlternatesId uniqueidentifier null
END
GO


IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pGRPOMAlterNates'
and COLUMN_NAME = N'NewPOMGuidId' )
BEGIN 
     alter table pGRPOMAlterNates ADD NewPOMGuidId uniqueidentifier null
END
GO


UPDATE pGRPOMAlterNates
   SET NewPOMGuidId = '00000000-0000-0000-0000-000000000000'
go

