Update rReportStylePageItem 
			
set ReportPageName = 'Construction Details (Longer Header)'

Where ReportFormName = 'Style_ConstructionDetails_Body_LLT'

GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01089', GetDate())
GO