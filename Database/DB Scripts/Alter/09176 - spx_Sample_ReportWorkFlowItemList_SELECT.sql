IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_ReportWorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_ReportWorkFlowItemList_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Sample_ReportWorkFlowItemList_SELECT] (
	@ReportMapID UNIQUEIDENTIFIER
	, @WorkflowItemId UNIQUEIDENTIFIER
	, @SampleApproved INTEGER
	)
AS
IF @ReportMapID = '00000000-0000-0000-0000-000000000000'
BEGIN
	IF @SampleApproved = 1
	BEGIN
		SELECT ReportSampleRequestSubmitPageID AS ReportPageID
			, ReportSampleRequestSubmitPageID AS ReportMapID
			, ReportPageTypeID
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive
			, ReportPageFormat
			, @WorkflowItemId AS WorkflowItemId
		FROM rReportSampleRequestSubmitItem
		WHERE ReportSampleRequestSubmitFolderID = @WorkflowItemId
			AND ReportPageActive = 1
		ORDER BY ReportPageSort ASC
	END
	ELSE IF @SampleApproved = 0
	BEGIN
		SELECT ReportSampleRequestSubmitPageID AS ReportPageID
			, ReportSampleRequestSubmitPageID AS ReportMapID
			, ReportPageTypeID
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive
			, ReportPageFormat
			, @WorkflowItemId AS WorkflowItemId
		FROM rReportSampleRequestSubmitItem
		WHERE ReportSampleRequestSubmitFolderID = @WorkflowItemId
			AND ReportPageActive = 1
			AND ReportPageApproved = 0
		ORDER BY ReportPageSort ASC
	END
END
ELSE
BEGIN
	SELECT ReportPageID
		, ReportMapID
		, ReportPageTypeID
		, ReportPageName
		, ReportPageDescription
		, ReportServerType
		, ReportPageURL
		, ReportPKIField
		, ReportPageActive
		, ReportPageFormat
		, @WorkflowItemId AS WorkflowItemId
	FROM rReportStylePageItem
	WHERE ReportMapID = @ReportMapID
		AND ReportPageActive = 1
		AND ReportIsWorkflow = 0
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09176', GetDate())
GO
