update rReportStylePageItem set ReportPageName = 'Text/Image Images With Text' where ReportPageName = 'Design Detail 2 Images Text Pair'
Go
update rReportStylePageItem set ReportPageName = 'Text/Image Images With Text & Comments (Longer Header)' where ReportPageName = 'Design Detail 2 Images Text Pair & Comments (Longer Header)'
GO
update rReportStylePageItem set ReportPageName = 'Process Details (Longer Header)' where ReportPageName = 'Construction Details (Longer Header)'
GO
update rReportStylePageItem set ReportPageName = 'Process Details & 3 User Defined' where ReportPageName = 'Construction Details & 3 User Defined'
GO
update rReportStylePageItem set ReportPageName = 'Process Details & 5 User Defined' where ReportPageName = 'Construction Details & 5 User Defined'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01234', GetDate())
GO