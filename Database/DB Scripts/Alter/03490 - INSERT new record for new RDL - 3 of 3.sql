/****************************************/
/*Work Item #8116 - Report 3 of 3.		*/
/*										*/
/*Script to add report record to table.	*/
/****************************************/


/*Declare variables.*/
BEGIN
	DECLARE @ReportPageId				UNIQUEIDENTIFIER
	DECLARE @ReportMapId				UNIQUEIDENTIFIER
	DECLARE @ReportPageTypeId			UNIQUEIDENTIFIER
	DECLARE @ReportTemplateName			NVARCHAR(300)
	DECLARE @ReportPageName				NVARCHAR(300)
	DECLARE @ReportPageDescription		NVARCHAR(4000)
	DECLARE @ReportServerType			NVARCHAR(10)
	DECLARE @ReportFormName				NVARCHAR(300)
	DECLARE @ReportPageURL				NVARCHAR(300)
	DECLARE @ReportPKIField				NVARCHAR(300)
	DECLARE @ReportPageActive			INT
	DECLARE @ReportPageFormat			NVARCHAR(50)
	DECLARE @ReportSrmOn				INT
END


/*Set variables.*/
BEGIN
	/*You need to set these manually.*/
	BEGIN
		SET @ReportMapId			= '40000000-0000-0000-0000-000000000888'	--Parent PK id.
		SET @ReportTemplateName		= 'Style_Header_LLT'						--Header RDL name.
		SET @ReportPageName			= 'Colorway Images - Grouped'				--Name of the new report to show on screen.
		SET @ReportPageDescription	= 'Colorway Images - Grouped'				--Additional name field, not shown on screen.
		SET @ReportServerType		= 'SQL'										--Report type.  'SQL' for RDLs and 'ASPX' for code-based reports.
		SET @ReportFormName			= 'Style_ColorwayImages_Grouped_Body_LLT'	--Body RDL name.
		SET @ReportPageActive		= 1											--Show report on screen, or not.
		SET @ReportSrmOn			= 1											--Show report on screen in srmOn, or not.
	END


	/*Automatically set for you.*/
	BEGIN
		SET @ReportPageId		= NEWID()										--Create a new PK id for the record.
		SET @ReportPageTypeId	= '00000000-0000-0000-0000-000000000000'
		SET @ReportPageURL		= '/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		SET @ReportPKIField		= 'StyleId'
		SET @ReportPageFormat	= 'PDF'
	END
END


/*Add the new record.*/
BEGIN
	/*Check to make sure a record doesn't already exist for this RDL.*/
	IF((SELECT COUNT(*) FROM rReportStylePageItem WHERE ReportFormName = @ReportFormName) = 0)
		BEGIN
			/*Insert script.*/
			INSERT INTO rReportStylePageItem(
				ReportPageId
				,ReportMapId
				,ReportPageTypeId
				,ReportTemplateName
				,ReportPageName
				,ReportPageDescription
				,ReportServerType				
				,ReportFormName
				,ReportPageURL
				,ReportPKIField
				,ReportPageActive
				,ReportPageFormat
				,ReportSrmOn
			)
			VALUES(
				@ReportPageId
				,@ReportMapId
				,@ReportPageTypeId
				,@ReportTemplateName
				,@ReportPageName
				,@ReportPageDescription
				,@ReportServerType				
				,@ReportFormName
				,@ReportPageURL
				,@ReportPKIField
				,@ReportPageActive
				,@ReportPageFormat
				,@ReportSrmOn
			)
			
			PRINT 'New report record added.'
		END
	ELSE
		BEGIN
			PRINT 'Report record already exists.  No new report record added.'
		END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03490', GetDate())
GO