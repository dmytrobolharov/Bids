Alter table pBodyPatternSheetModel alter column Model_Name nvarchar(50)
Alter table pBodyPatternSheetModel alter column CUser nvarchar(200)
Alter table pBodyPatternSheetModel alter column MUser nvarchar(200)
Alter table pBodyPatternSheetModel alter column Model_Description nvarchar(255)
Alter table pBodyPatternSheetModel alter column Model_CrOpId nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_RevOp1 nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_RevOp2 nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_GRTable nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_MTMFile nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_SAName nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_SYNTable nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_HPTable nvarchar(50)
Alter table pBodyPatternSheetModel alter column Model_SampleSize nvarchar(50)
Alter table pBodyPatternSheetModel alter column UserDefined1 nvarchar(50)
Alter table pBodyPatternSheetModel alter column UserDefined2 nvarchar(50)
Alter table pBodyPatternSheetModel alter column UserDefined3 nvarchar(50)
Alter table pBodyPatternSheetModel alter column UserDefined4 nvarchar(50)
Alter table pBodyPatternSheetModel alter column UserDefined5 nvarchar(50)
Alter table pBodyPatternSheetModel alter column PlotFileLocation nvarchar(255)
Alter table pBodyPatternSheetModel alter column NotchFile nvarchar(50)
Alter table pBodyPatternSheetModel alter column AnnotationFile nvarchar(50)


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02247'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02247', GetDate())
END	
GO