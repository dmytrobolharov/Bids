
DELETE FROM Mapping
WHERE Map = '40000000-0000-0000-0000-000000000020'
GO

INSERT INTO Mapping(Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder, Sort, MapConceptUrl, MapConceptEditUrl)
VALUES     ('40000000-0000-0000-0000-000000000020', 'Color Group', 'Style_ColorGroup.aspx', 'Style_ColorGroup_Edit.aspx', NULL, 'StyleFolder', NULL, NULL, NULL)

GO

INSERT INTO pWorkflow(WorkflowID,Workflow,WorkDays,WorkAlert,WorkflowSort,CUser,CDate,MUser,MDate,Active,Body,WorkflowTypeID)
VALUES     ('40000000-0000-0000-0000-000000000020','Color Group','2','10','9',NULL,NULL,NULL,NULL,'True','0','D')

GO

INSERT INTO rReportStylePageItem
                      (ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
VALUES ('4cb4ea80-c34c-4bbd-8f35-e1dbcaa76e27','40000000-0000-0000-0000-000000000020','00000000-0000-0000-0000-000000000000','Style_Header_LLT','Color Groups','Style Color Groups','SQL','Style_ColorGroups_Body_LLT','/StyleReportRedirect.aspx?RPID=##RPID##&SID=','StyleId','1','PDF','1')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '005', GetDate())
GO