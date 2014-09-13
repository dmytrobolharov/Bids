update pWorkflow set Workflow = 'Text-Image' where WorkflowID = '40000000-0000-0000-0000-000000000018'
GO
update Mapping set MapDetail = 'Text-Image' where Map = '40000000-0000-0000-0000-000000000018'
GO
update rReportStylePageItem set ReportPageName = 'Text-Image Images With Text', ReportPageDescription = 'Text-Image' where ReportMapID = '40000000-0000-0000-0000-000000000018' and ReportPageName = 'Text/Image Images With Text'
GO
update rReportStylePageItem set ReportPageName = 'Text-Image Images With Text & Comments (Longer Header)', ReportPageDescription = 'Text-Image' where ReportMapID = '40000000-0000-0000-0000-000000000018' and ReportPageName = 'Text/Image Images With Text & Comments (Longer Header)'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01322', GetDate())
GO