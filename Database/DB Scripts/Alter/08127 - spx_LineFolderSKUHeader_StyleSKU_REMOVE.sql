IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderSKUHeader_StyleSKU_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderSKUHeader_StyleSKU_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderSKUHeader_StyleSKU_REMOVE]
	@StyleSKUItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @LineFolderSKUHeaderID UNIQUEIDENTIFIER = (SELECT LineFolderSKUHeaderID FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID)
	
	UPDATE pStyleSKUItem SET LineFolderSKUHeaderID = NULL 
	WHERE StyleSKUItemID = @StyleSKUItemID
	
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
		INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
				ChangeSubject, ChangeType)
		SELECT '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', @LineFolderSKUHeaderID, 'LineFolderSKUHeaderID', sh.StyleNo + ' Style SKU Page',
				ssh.StyleSKUItemID, @StyleSKUItemID, wfi.WorkFlowItemName, '',
				'', 0
		FROM pStyleSKUItem ssh
		INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID		
		INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
		WHERE ssh.StyleSKUItemID = @StyleSKUItemID
	END
	
	SELECT * FROM @ChangeLog
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08127', GetDate())
GO
