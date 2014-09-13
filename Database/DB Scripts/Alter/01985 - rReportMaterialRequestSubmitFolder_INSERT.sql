if (select COUNT(*) from rReportMaterialRequestSubmitFolder where ReportMaterialRequestSubmitFolderID = 'A1000000-0000-0000-0000-000000000001') = 0
INSERT INTO rReportMaterialRequestSubmitFolder
           (ReportMaterialRequestSubmitFolderID
           ,ReportMaterialRequestSubmitName
           ,ReportMaterialRequestSubmitFormName
           ,ReportMaterialRequestSubmitGroup
           ,ReportMaterialRequestSubmitFinal
           ,ReportMaterialRequestSubmitSort
           ,Active
           ,srmOn)
     VALUES
           ('a1000000-0000-0000-0000-000000000001'
           ,'Material Request Submit'
           ,'Material Submit'
           ,'0'
           ,1
           ,'1'
           ,1
           ,1)


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01985'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01985', GetDate())

END

GO

