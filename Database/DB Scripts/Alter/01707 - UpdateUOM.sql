IF EXISTS (SELECT UOMValue FROM UOM WHERE UOM = 'Meter')
	UPDATE UOM SET UOMValue = 'Meter' WHERE UOM = 'Meter'
GO
IF EXISTS (SELECT UOMValue FROM UOM WHERE UOM = 'Millimeter')
	UPDATE UOM SET UOMValue = 'Millimeter' WHERE UOM = 'Millimeter'
GO
IF EXISTS (SELECT UOMValue FROM UOM WHERE UOM = 'N/A')
	UPDATE UOM SET UOMValue = 'N/A' WHERE UOM = 'N/A'
GO
IF EXISTS (SELECT UOMValue FROM UOM WHERE UOM = 'Pounds')
	UPDATE UOM SET UOMValue = 'Pounds' WHERE UOM = 'Pounds'
GO
IF EXISTS (SELECT UOMValue FROM UOM WHERE UOM = 'Yard')
	UPDATE UOM SET UOMValue = 'Yard' WHERE UOM = 'Yard'
GO
IF EXISTS (SELECT UOMValue FROM UOM WHERE UOM = 'Each')
	UPDATE UOM SET UOMValue = '1' WHERE UOM = 'Each'
GO
---------------------------------------------
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01707'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01707', GetDate())
END
GO
