Update rReportStylePageItem 
			
set ReportPageName = 'Design Detail 2 Images Text Pair & Comments (Longer Header)'

Where ReportFormName = 'Style_DesignDetail2_2_Body_LLT'

GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01087', GetDate())
GO