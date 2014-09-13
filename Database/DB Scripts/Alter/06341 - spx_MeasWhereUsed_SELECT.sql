IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MeasWhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MeasWhereUsed_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MeasWhereUsed_SELECT]    Script Date: 09/23/2013 13:24:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_MeasWhereUsed_SELECT]
(
	@WorkflowItemID UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @ShowParent INT
	, @ConfigFile NVARCHAR(256) = 'report.config'
)
AS
BEGIN
	DECLARE @ServerUrl NVARCHAR(100)
	SELECT @ServerUrl=AppSettingValue FROM sAppSetting WHERE ConfigFileName = @ConfigFile AND AppSettingKey = 'plmOnApplicationServerUrl'

	SELECT
		'<span style="font-weight:bold;">Source Style:</span><span style="padding-bottom:5px; display:block; border-bottom:1 dashed black;">' + ISNULL (sh.StyleNo, '') + ISNULL(' - ' + sh.Description, '') + '</span>' AS StyleInfo
		, @ServerUrl + '/Style/Style_Frame.aspx?SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&P=40000000-0000-0000-0000-000000000050' AS StyleLink
		, '00000000-0000-0000-0000-000000000000' AS WorkFlowItemLinkedID
		, 'Source Style: ' + ISNULL (sh.StyleNo, '')  AS MenuStyleInfo
		, @ServerUrl + '/Style/Style_DevelopmentMeas.aspx?SN=' + CAST(@StyleSet AS NVARCHAR(3)) + '&WFID=40000000-0000-0000-0000-000000000050&WFIID=' + CAST(@WorkflowItemID AS NVARCHAR(50)) + '&SWID=40000000-0000-0000-0000-000000000050&SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&SDID=' + CAST(sh.DevelopmentID AS NVARCHAR(50)) + '&STP=V&RO=1' AS MenuStyleLink
		, '' AS Icon
	FROM pWorkFlowItem wfi
		INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
	WHERE wfi.WorkFlowItemID = @WorkflowItemID AND @ShowParent = 1
	UNION
	SELECT
		ISNULL (sh.StyleNo, '') + ISNULL(' - ' + sh.Description, '') AS StyleInfo
		, @ServerUrl + '/Style/Style_Frame.aspx?SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&P=40000000-0000-0000-0000-000000000050' AS StyleLink
		, wfil.WorkFlowItemLinkedID
		, ISNULL (sh.StyleNo, '') + ISNULL(' - ' + sh.Description, '') AS MenuStyleInfo
		, @ServerUrl + '/Style/Style_DevelopmentMeas.aspx?SN=' + CAST(@StyleSet AS NVARCHAR(3)) + '&WFID=40000000-0000-0000-0000-000000000050&WFIID=' + CAST(@WorkflowItemID AS NVARCHAR(50)) + '&SWID=40000000-0000-0000-0000-000000000050&SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&SDID=' + CAST(sh.DevelopmentID AS NVARCHAR(50)) + '&STP=V&RO=1' AS MenuStyleLink
		, 'icon_link.gif' AS Icon
	FROM pWorkFlowItemLinked wfil
		INNER JOIN pStyleHeader sh ON wfil.StyleID = sh.StyleID
	WHERE wfil.WorkFlowItemID = @WorkflowItemID
		AND (wfil.StyleID <> @StyleID
		OR wfil.StyleSet <> @StyleSet)

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06341', GetDate())
GO