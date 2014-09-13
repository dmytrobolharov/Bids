alter table pBodyPatternSheetModel alter column Model_Image_Name nvarchar(255)
alter table pBodyPatternSheetModel alter column Model_Comments nvarchar(max)

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02263'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02263', GetDate())
END	
GO