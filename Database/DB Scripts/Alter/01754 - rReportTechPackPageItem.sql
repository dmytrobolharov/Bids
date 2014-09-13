DELETE
FROM rReportTechPackPageItem
WHERE ReportFormName = 'Style_DesignDetail2_Body_LLT' and ReportMapID = '40000000-0000-0000-0000-000000000018'
GO
DELETE
FROM rReportTechPackPageItem
WHERE ReportFormName = 'Style_ConstructionDetails_3_Body_LLT' and ReportMapID = '80000000-0000-0000-0000-000000000008'
GO
DELETE
FROM rReportTechPackPageItem
WHERE ReportFormName = 'Style_Measurement_Imperial_Body_LLT' and ReportMapID = '40000000-0000-0000-0000-000000000050'
GO
INSERT INTO rReportTechPackPageItem
           (ReportTechPackPageID
           ,ReportTechPackFolderID
           ,ReportPageTypeID
           ,ReportTemplateName
           ,ReportPageName
           ,ReportPageDescription
           ,ReportServerType
           ,ReportFormName
           ,ReportPageURL
           ,ReportPKIField
           ,ReportPageActive
           ,ReportPageFormat
           ,ReportPageBySet
           ,ReportPageSort
           ,ReportMapID
           ,ReportSourcing)
     VALUES
           (NEWID()
           ,'f1000000-0000-0000-0000-000000000010'
           ,'00000000-0000-0000-0000-000000000000'
           ,'Style_Header_LLT'
           ,'Text-Image Images With Text'
           ,'Text-Image'
           ,'SQL'
           ,'Style_DesignDetail2_Body_LLT'
           ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
           ,'StyleID'
           ,1
           ,'PDF'
           ,1
           ,'006'
           ,'40000000-0000-0000-0000-000000000018'
           ,0)
           
  INSERT INTO rReportTechPackPageItem
           (ReportTechPackPageID
           ,ReportTechPackFolderID
           ,ReportPageTypeID
           ,ReportTemplateName
           ,ReportPageName
           ,ReportPageDescription
           ,ReportServerType
           ,ReportFormName
           ,ReportPageURL
           ,ReportPKIField
           ,ReportPageActive
           ,ReportPageFormat
           ,ReportPageBySet
           ,ReportPageSort
           ,ReportMapID
           ,ReportSourcing)
     VALUES
           (NEWID()
           ,'f1000000-0000-0000-0000-000000000001'
           ,'00000000-0000-0000-0000-000000000000'
           ,'Style_Header_LLT'
           ,'Text-Image Images With Text'
           ,'Text-Image'
           ,'SQL'
           ,'Style_DesignDetail2_Body_LLT'
           ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
           ,'StyleID'
           ,1
           ,'PDF'
           ,1
           ,'011'
           ,'40000000-0000-0000-0000-000000000018'
           ,0) 
                   
   INSERT INTO rReportTechPackPageItem
           (ReportTechPackPageID
           ,ReportTechPackFolderID
           ,ReportPageTypeID
           ,ReportTemplateName
           ,ReportPageName
           ,ReportPageDescription
           ,ReportServerType
           ,ReportFormName
           ,ReportPageURL
           ,ReportPKIField
           ,ReportPageActive
           ,ReportPageFormat
           ,ReportPageBySet
           ,ReportPageSort
           ,ReportMapID
           ,ReportSourcing)
     VALUES
           (NEWID()
           ,'f1000000-0000-0000-0000-000000000010'
           ,'00000000-0000-0000-0000-000000000000'
           ,'Style_Header_LLT'
           ,'Process Details & 5 User Defined'
           ,'Style Process Details'
           ,'SQL'
           ,'Style_ConstructionDetails_3_Body_LLT'
           ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
           ,'StyleID'
           ,1
           ,'PDF'
           ,1
           ,'007'
           ,'80000000-0000-0000-0000-000000000008'
           ,0)
           
   INSERT INTO rReportTechPackPageItem
           (ReportTechPackPageID
           ,ReportTechPackFolderID
           ,ReportPageTypeID
           ,ReportTemplateName
           ,ReportPageName
           ,ReportPageDescription
           ,ReportServerType
           ,ReportFormName
           ,ReportPageURL
           ,ReportPKIField
           ,ReportPageActive
           ,ReportPageFormat
           ,ReportPageBySet
           ,ReportPageSort
           ,ReportMapID
           ,ReportSourcing)
     VALUES
           (NEWID()
           ,'f1000000-0000-0000-0000-000000000001'
           ,'00000000-0000-0000-0000-000000000000'
           ,'Style_Header_LLT'
           ,'Process Details & 5 User Defined'
           ,'Style Process Details'
           ,'SQL'
           ,'Style_ConstructionDetails_3_Body_LLT'
           ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
           ,'StyleID'
           ,1
           ,'PDF'
           ,1
           ,'012'
           ,'80000000-0000-0000-0000-000000000008'
           ,0) 
           
           
    INSERT INTO rReportTechPackPageItem
           (ReportTechPackPageID
           ,ReportTechPackFolderID
           ,ReportPageTypeID
           ,ReportTemplateName
           ,ReportPageName
           ,ReportPageDescription
           ,ReportServerType
           ,ReportFormName
           ,ReportPageURL
           ,ReportPKIField
           ,ReportPageActive
           ,ReportPageFormat
           ,ReportPageBySet
           ,ReportPageSort
           ,ReportMapID
           ,ReportSourcing)
     VALUES
           (NEWID()
           ,'f1000000-0000-0000-0000-000000000010'
           ,'00000000-0000-0000-0000-000000000000'
           ,'Style_Header_LLT'
           ,'Measurement Imperial View'
           ,'Style Measurement'
           ,'SQL'
           ,'Style_Measurement_Imperial_Body_LLT'
           ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
           ,'StyleID'
           ,1
           ,'PDF'
           ,1
           ,'008'
           ,'40000000-0000-0000-0000-000000000050'
           ,0)
           
   INSERT INTO rReportTechPackPageItem
           (ReportTechPackPageID
           ,ReportTechPackFolderID
           ,ReportPageTypeID
           ,ReportTemplateName
           ,ReportPageName
           ,ReportPageDescription
           ,ReportServerType
           ,ReportFormName
           ,ReportPageURL
           ,ReportPKIField
           ,ReportPageActive
           ,ReportPageFormat
           ,ReportPageBySet
           ,ReportPageSort
           ,ReportMapID
           ,ReportSourcing)
     VALUES
           (NEWID()
           ,'f1000000-0000-0000-0000-000000000001'
           ,'00000000-0000-0000-0000-000000000000'
           ,'Style_Header_LLT'
           ,'Measurement Imperial View'
           ,'Style Measurement'
           ,'SQL'
           ,'Style_Measurement_Imperial_Body_LLT'
           ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
           ,'StyleID'
           ,1
           ,'PDF'
           ,1
           ,'013'
           ,'40000000-0000-0000-0000-000000000050'
           ,0)           
           
           
                         
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01754'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01754', GetDate())
	END
GO