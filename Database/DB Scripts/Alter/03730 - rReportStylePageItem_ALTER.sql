IF((SELECT COUNT(*) FROM rReportStylePageItem WHERE ReportFormName = 'Style_ConstructionDetails_Body_Big_Img_LLT') = 0)
BEGIN
	UPDATE rReportStylePageItem SET ReportFormName='Style_ConstructionDetails_Body_Big_Img_LLT' 
	WHERE ReportPageName='Process Details (Longer Header)' AND ReportMapID = '80000000-0000-0000-0000-000000000008'
END

IF((SELECT COUNT(*) FROM rReportStylePageItem WHERE ReportFormName = 'Style_ConstructionDetails_2_Body_Big_Img_LLT') = 0)
BEGIN
	UPDATE rReportStylePageItem SET ReportFormName='Style_ConstructionDetails_2_Body_Big_Img_LLT' 
	WHERE ReportPageName='Process Details & 3 User Defined' AND ReportMapID = '80000000-0000-0000-0000-000000000008'
END

IF((SELECT COUNT(*) FROM rReportStylePageItem WHERE ReportFormName = 'Style_ConstructionDetails_3_Body_Big_Img_LLT') = 0)
BEGIN
	UPDATE rReportStylePageItem SET ReportFormName='Style_ConstructionDetails_3_Body_Big_Img_LLT' 
	WHERE ReportPageName='Process Details & 5 User Defined' AND ReportMapID = '80000000-0000-0000-0000-000000000008'
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03730', GetDate())
GO