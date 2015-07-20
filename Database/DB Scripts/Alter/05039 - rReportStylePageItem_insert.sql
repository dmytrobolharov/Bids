
INSERT INTO rReportStylePageItem
                      (ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
VALUES (newid(),'40000000-0000-0000-0000-000000000021','00000000-0000-0000-0000-000000000000','Style_Header_LLT','Seasonal','Style Seasonal Colors','SQL','Style_Seasonal_Colors_Body_LLT','/StyleReportRedirect.aspx?RPID=##RPID##&SID=','StyleId','1','PDF','1')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05039', GetDate())
GO
