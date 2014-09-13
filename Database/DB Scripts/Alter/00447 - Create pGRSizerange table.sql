
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pGRClassRange')
CREATE TABLE pGRClassRange(
	ClassRangeId uniqueidentifier NOT NULL,
	SizeClassGuidId uniqueidentifier NOT NULL,
	SizeRangeGuidId uniqueidentifier NOT NULL,
	CUser nchar(25) NULL,
	CDate datetime NULL)
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '447', GetDate())
GO
