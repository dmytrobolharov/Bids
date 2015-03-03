IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Portrait_Style_Report_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Portrait_Style_Report_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Portrait_Style_Report_INSERT]
(
	@ReportFormName NVARCHAR(255)
	, @ReportTemplateName NVARCHAR(255)
	, @ReportMapID UNIQUEIDENTIFIER
	, @ReportPageName NVARCHAR(500)
	, @ReportPageDescription NVARCHAR(500)
)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = @ReportFormName)
		INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
		VALUES (NEWID(), @ReportMapID, '00000000-0000-0000-0000-000000000000', @ReportTemplateName, @ReportPageName, @ReportPageDescription, 'SQL', @ReportFormName, '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Coversheet_PLT', 'Blank', '70000000-0000-0000-0000-000000000001', 'Style Cover Portrait', 'Style Cover'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Care_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000013', 'Style Care Portrait', 'Style Care Instruction'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_LookBook_Summary_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000085', 'Style Look Book Summary 4 Images (Portrait)', 'Style Look Book Summary Report'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_DesignDetail_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000006', 'Design Detail Single Image Portrait', 'Style Design Detail'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_DesignDetail2_2_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000018', 'Text-Image Images With Text & Comments (Portrait)', 'Text-Image'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_DesignDetail2_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000018', 'Text-Image Images With Text (Portrait)', 'Text-Image'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Freelance_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000999', 'Freelance Design Single Image Portrait', 'Style Freelance Design'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_MaterialArtwork_2_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000010', 'Material Artwork Portrait (Two Image Per Page)', 'Style Material Artwork 2 Per Page'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_MaterialArtwork_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000010', 'Material Artwork Portrait (One Image Per Page)', 'Style Material Artwork'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Measurement_Imperial_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000050', 'Measurement Imperial View Portrait', 'Style Measurement'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Measurement_Metric_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000050', 'Measurement Metric View Portrait', 'Style Measurement'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Measurement_Sample_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000050', 'Measurement Sample Portrait', 'Style Measurement'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Measurement_Worksheet_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000050', 'Measurement WorkSheet Portrait', 'Style Measurement'
GO

EXEC spx_Portrait_Style_Report_INSERT 'v5_Style_Model_1x1_Body_PLT', 'v5_Style_Header_PLT', '40000000-0000-0000-0000-000000000037', 'Model - 1 Image per Page', 'Model - 1 Image per Page'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Portrait_Style_Report_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Portrait_Style_Report_INSERT]
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09147', GetDate())
GO