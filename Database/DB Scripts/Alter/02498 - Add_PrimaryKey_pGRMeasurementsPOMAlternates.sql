ALTER Table pGRMeasurementsPOMAlternates ADD MeasPOMAltId uniqueidentifier null default NEWSEQUENTIALID ( )
GO

UPDATE  pGRMeasurementsPOMAlternates
   SET MeasPOMAltId = NewID()
WHERE MeasPOMAltId IS NULL
GO

ALTER Table pGRMeasurementsPOMAlternates ALTER COLUMN MeasPOMAltId uniqueidentifier Not null
GO

ALTER TABLE pGRMeasurementsPOMAlternates
 ADD CONSTRAINT [PK_pGRMeasurementsPOMAlternates_MeasPOMAltId]
 PRIMARY KEY CLUSTERED
 (
 [MeasPOMAltId] ASC
 )
 GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02498'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02498', GetDate())
END
GO