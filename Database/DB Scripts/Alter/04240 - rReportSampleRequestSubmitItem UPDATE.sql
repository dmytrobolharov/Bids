update rReportSampleRequestSubmitItem set ReportPageName='Sample Header', ReportPageDescription='Sample Request Header' where ReportFormName like '%coversheet%'
update rReportSampleRequestSubmitItem set ReportPageName='Sample Fit Photos', ReportPageDescription='Sample Request Fit Photos' where ReportFormName like '%fitphoto%'
update rReportSampleRequestSubmitItem set ReportPageName='Sample Submit', ReportPageDescription='Sample Request Submit' where ReportFormName like '%measurement%'
update rReportSampleRequestSubmitItem set ReportPageName='Sample Comments', ReportPageDescription='Sample Request Comments' where ReportFormName like '%vendorcomments%'
update rReportSampleRequestSubmitItem set ReportPageName='Sample Images', ReportPageDescription='Sample Request Images' where ReportFormName like '%attachedimages%'

GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04240', GetDate())
GO