IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderSKUHeader_StyleSKU_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderSKUHeader_StyleSKU_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderSKUHeader_StyleSKU_DELETE]
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

	IF @StyleSKUItemID IS NOT NULL
	BEGIN
	
		IF @ChangeManagement = 'TRUE'
		BEGIN
			DECLARE @LineFolderSKUHeaderID UNIQUEIDENTIFIER
			SELECT @LineFolderSKUHeaderID = LineFolderSKUHeaderID 
			FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID
			
			INSERT INTO @ChangeLog(
					ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
					ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
					ChangeSubject, ChangeType)
			SELECT '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', @LineFolderSKUHeaderID, 'LineFolderSKUHeaderID', sh.StyleNo + ' Style SKU Page',
					ssh.StyleSKUItemID, @StyleSKUItemID, wfi.WorkFlowItemName, '',
					'', 2
			FROM pStyleSKUItem ssh
			INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID		
			INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
			WHERE ssh.StyleSKUItemID = @StyleSKUItemID
		END

		DECLARE @WorkflowID UNIQUEIDENTIFIER,
				@WorkflowItemID UNIQUEIDENTIFIER,
				@StyleID UNIQUEIDENTIFIER,
				@StyleSet INT
				
		SELECT @WorkflowID = wfi.WorkflowID,
			@WorkflowItemID = wfi.WorkFlowItemID,
			@StyleID = wfi.StyleID,
			@StyleSet = wfi.StyleSet
		FROM pStyleSKUItem ssh
		INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
		WHERE ssh.StyleSKUItemID = @StyleSKUItemID
		
		EXEC spx_WorkflowItem_Seasonal_DELETE
			@WorkflowID = @WorkflowID,
			@WorkflowItemID = @WorkflowItemID,			
			@StyleID = @StyleID,
			@StyleSet = @StyleSet
		
	END
	
	SELECT * FROM @ChangeLog
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08124', GetDate())
GO
