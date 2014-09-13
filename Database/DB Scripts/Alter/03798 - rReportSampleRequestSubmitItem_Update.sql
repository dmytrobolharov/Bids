update  rReportSampleRequestSubmitItem
set ReportPageName = 'Sample Submit', ReportPageDescription = 'Sample Request Submit'
WHERE     (ReportSampleRequestSubmitFolderID = 'F1000000-0000-0000-0000-000000000050') AND 
                      (ReportSampleRequestSubmitPageID = '0004ea80-c34c-4bbd-8f35-e1dbcaa76000')

GO
update  rReportSampleRequestSubmitItem
set ReportPageName = 'Sample Comments', ReportPageDescription = 'Sample Request Comments'
WHERE     (ReportSampleRequestSubmitFolderID = 'F1000000-0000-0000-0000-000000000050') AND 
                      (ReportSampleRequestSubmitPageID = '0004ea80-c34c-4bbd-8f35-e1dbcaa76002')
GO

update  rReportSampleRequestSubmitItem
set ReportPageName = 'Sample Images', ReportPageDescription = 'Sample Request Images'
WHERE     (ReportSampleRequestSubmitFolderID = 'F1000000-0000-0000-0000-000000000050') AND 
                      (ReportSampleRequestSubmitPageID = '0004ea80-c34c-4bbd-8f35-e1dbcaa76003')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03798', GetDate())
GO
