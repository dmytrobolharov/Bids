
INSERT INTO Mapping
                      (Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder, Sort, MapConceptUrl, MapConceptEditUrl)
VALUES     ('40000000-0000-0000-0000-000000000021', 'Seasonal', 'Style_ColorwaySeasonal.aspx', 'Style_ColorwaySeasonal_Edit.aspx', NULL, 'StyleFolder', NULL, NULL, NULL)
GO

INSERT INTO pWorkflow
                      (WorkflowID,Workflow,WorkDays,WorkAlert,WorkflowSort,CUser,CDate,MUser,MDate,Active,Body,WorkflowTypeID)
VALUES     ('40000000-0000-0000-0000-000000000021','Seasonal','2','10','9',NULL,NULL,NULL,NULL,'True','0','D')
GO

INSERT INTO rReportStylePageItem
                      (ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
VALUES (newid(),'40000000-0000-0000-0000-000000000021','00000000-0000-0000-0000-000000000000','Style_Header_LLT','Seasonal','Style Seasonal Colors','SQL','Style_Seasonal_Colors_Body_LLT','/StyleReportRedirect.aspx?RPID=##RPID##&SID=','StyleId','1','PDF','1')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '026', GetDate())
GO