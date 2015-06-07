IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dvtComponentSizeHeaderName' AND COLUMN_NAME='CUser')
BEGIN
	ALTER TABLE dvtComponentSizeHeaderName
	ALTER COLUMN CUser NVARCHAR(200)
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dvtComponentSizeHeaderName' AND COLUMN_NAME='MUser')
BEGIN
	ALTER TABLE dvtComponentSizeHeaderName
	ALTER COLUMN MUser NVARCHAR(200)
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dvtComponentTypeCode' AND COLUMN_NAME='CUser')
BEGIN
	ALTER TABLE dvtComponentTypeCode
	ALTER COLUMN CUser NVARCHAR(200)
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dvtComponentTypeCode' AND COLUMN_NAME='MUser')
BEGIN
	ALTER TABLE dvtComponentTypeCode
	ALTER COLUMN MUser NVARCHAR(200)
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dvtImageClass' AND COLUMN_NAME='CUser')
BEGIN
	ALTER TABLE dvtImageClass
	ALTER COLUMN CUser NVARCHAR(200)
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dvtImageClass' AND COLUMN_NAME='MUser')
BEGIN
	ALTER TABLE dvtImageClass
	ALTER COLUMN MUser NVARCHAR(200)
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='sServiceBusMessage' AND COLUMN_NAME='CUser')
BEGIN
	ALTER TABLE sServiceBusMessage
	ALTER COLUMN CUser NVARCHAR(200)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09873', GetDate())
GO
