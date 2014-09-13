IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSKUHeader_StyleSKU_LINK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSKUHeader_StyleSKU_LINK]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSKUHeader_StyleSKU_LINK]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER,
	@PlanningItemID UNIQUEIDENTIFIER,
	@StyleSKUItemID UNIQUEIDENTIFIER = NULL,
	@WorkflowItemID UNIQUEIDENTIFIER = NULL
AS
BEGIN	

	IF @StyleSKUItemID IS NULL
		SELECT @StyleSKUItemID = StyleSKUItemID 
		FROM pStyleSKUItem WHERE WorkflowItemID = @WorkflowItemID

	DECLARE @StyleID UNIQUEIDENTIFIER,
			@StyleSeasonYearID UNIQUEIDENTIFIER
			
	SELECT @StyleID = StyleID,
		@StyleSeasonYearID = StyleSeasonYearID
	FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
			
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
		DECLARE @AfterText NVARCHAR(200)
		SELECT @AfterText = wfi.WorkFlowItemName 
		FROM pStyleSKUItem ssh
		INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
		WHERE ssh.StyleSKUItemID = @StyleSKUItemID
		
		IF EXISTS(SELECT * FROM pStyleSKUItem ssh
					INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
					WHERE ssh.PlanningSKUHeaderID = @PlanningSKUHeaderID
						AND wfi.StyleID = @StyleID)
		BEGIN		
			INSERT INTO @ChangeLog(
					ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
					ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
					ChangeSubject, ChangeType)
			SELECT '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', @PlanningSKUHeaderID, 'PlanningSKUHeaderID', sh.StyleNo + ' Style SKU Page',
					ssh.StyleSKUItemID, @StyleSKUItemID, wfi.WorkFlowItemName, @AfterText,
					'', 0
			FROM pStyleSKUItem ssh
			INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID		
			INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
			WHERE ssh.PlanningSKUHeaderID = @PlanningSKUHeaderID
				AND wfi.StyleID = @StyleID
		END
		ELSE
		BEGIN
			INSERT INTO @ChangeLog(
					ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
					ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
					ChangeSubject, ChangeType)
			SELECT '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', @PlanningSKUHeaderID, 'PlanningSKUHeaderID', sh.StyleNo + ' Style SKU Page',
					'', @StyleSKUItemID, '', @AfterText, '', 0
			FROM pStyleHeader sh WHERE StyleID = @StyleID
		END
	END
	-- End change Log
	
	-- remove old link
	UPDATE ssh SET PlanningSKUHeaderID = NULL
	FROM pStyleSKUItem ssh
	INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
	WHERE ssh.PlanningSKUHeaderID = @PlanningSKUHeaderID
		AND wfi.StyleID = @StyleID
	
	UPDATE pStyleSKUItem SET PlanningSKUHeaderID = @PlanningSKUHeaderID
	WHERE StyleSKUItemID = @StyleSKUItemID
	
	SELECT * FROM @ChangeLog
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07980', GetDate())
GO
