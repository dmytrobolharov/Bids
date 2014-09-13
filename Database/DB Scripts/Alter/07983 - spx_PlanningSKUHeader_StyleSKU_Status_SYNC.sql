IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSKUHeader_StyleSKU_Status_SYNC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSKUHeader_StyleSKU_Status_SYNC]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSKUHeader_StyleSKU_Status_SYNC]
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
		DECLARE @PlanningSKUHeaderID UNIQUEIDENTIFIER
		SELECT @PlanningSKUHeaderID = PlanningSKUHeaderID 
		FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID
		
		INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
				ChangeSubject, ChangeType)
		SELECT '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', @PlanningSKUHeaderID, 'PlanningSKUHeaderID', sh.StyleNo + ' ' + wfi.WorkFlowItemName + ' SKU Page: Status',
				wfi.WorkStatus, psh.WorkStatus, ws1.WorkflowStatus , ws2.WorkflowStatus,
				'', 0
		FROM pStyleSKUItem ssh
		INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
		LEFT JOIN pWorkflowStatus ws1 ON wfi.WorkStatus = ws1.WorkflowStatusID
		INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
		INNER JOIN pPlanningSKUHeader psh ON ssh.PlanningSKUHeaderID = psh.PlanningSKUHeaderID
		LEFT JOIN pWorkflowStatus ws2 ON psh.WorkStatus = ws2.WorkflowStatusID
		WHERE ssh.StyleSKUItemID = @StyleSKUItemID AND wfi.WorkStatus <> psh.WorkStatus
	END
	
	UPDATE wfi SET wfi.WorkStatus = psh.WorkStatus
	FROM pStyleSKUItem ssh
	INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
	INNER JOIN pPlanningSKUHeader psh ON ssh.PlanningSKUHeaderID = psh.PlanningSKUHeaderID
	WHERE ssh.StyleSKUItemID = @StyleSKUItemID
	
	SELECT * FROM @ChangeLog
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07983', GetDate())
GO
