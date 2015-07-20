IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderSKUHeader_StyleSKU_Status_SYNC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderSKUHeader_StyleSKU_Status_SYNC]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderSKUHeader_StyleSKU_Status_SYNC]
	@StyleSKUItemID UNIQUEIDENTIFIER
AS
BEGIN

	-- Change Log
	DECLARE @ChangeManagement nVARCHAR(5) = (SELECT UPPER(RTRIM(LTRIM(AppSettingValue))) FROM sAppSetting WHERE AppSettingKey = 'ChangeManagementEnabled')	
	DECLARE @ChangeLog TABLE(
		ChangeTableID UNIQUEIDENTIFIER,
		ChangeTablePKID UNIQUEIDENTIFIER,
		ChangeFieldName NVARCHAR(200),
		ChangeFieldAlias NVARCHAR(200),
		ChangeBeforeValue NVARCHAR(200),
		ChangeAfterValue NVARCHAR(200),
		ChangeBeforeText NVARCHAR(4000),
		ChangeAfterText NVARCHAR(4000),
		ChangeSubject NVARCHAR(400),
		ChangeType INT
	)
	
	IF @ChangeManagement = 'TRUE'
	BEGIN
		DECLARE @LineFolderSKUHeaderID UNIQUEIDENTIFIER
		SELECT @LineFolderSKUHeaderID = LineFolderSKUHeaderID 
		FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID
		
		INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
				ChangeSubject, ChangeType)
		SELECT '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', @LineFolderSKUHeaderID, 'LineFolderSKUHeaderID', sh.StyleNo + ' ' + wfi.WorkFlowItemName + ' SKU Page: Status',
				wfi.WorkStatus, lfsh.WorkStatus, ws1.WorkflowStatus , ws2.WorkflowStatus,
				'', 0
		FROM pStyleSKUItem ssh
		INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
		LEFT JOIN pWorkflowStatus ws1 ON wfi.WorkStatus = ws1.WorkflowStatusID
		INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
		INNER JOIN pLineFolderSKUHeader lfsh ON ssh.LineFolderSKUHeaderID = lfsh.LineFolderSKUHeaderID
		LEFT JOIN pWorkflowStatus ws2 ON lfsh.WorkStatus = ws2.WorkflowStatusID
		WHERE ssh.StyleSKUItemID = @StyleSKUItemID AND wfi.WorkStatus <> lfsh.WorkStatus
	END
	
	UPDATE wfi SET wfi.WorkStatus = lfsh.WorkStatus
	FROM pStyleSKUItem ssh
	INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
	INNER JOIN pLineFolderSKUHeader lfsh ON ssh.LineFolderSKUHeaderID = lfsh.LineFolderSKUHeaderID
	WHERE ssh.StyleSKUItemID = @StyleSKUItemID
	
	SELECT * FROM @ChangeLog
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08128', GetDate())
GO
