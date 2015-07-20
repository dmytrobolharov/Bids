IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_BOM_LINK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_BOM_LINK]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_BOM_LINK]
(
	@PlanningItemID UNIQUEIDENTIFIER
	, @WorkflowItemID UNIQUEIDENTIFIER
	, @isSave INT = 0
)

AS
BEGIN
	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
	
	IF @isSave = 0
		SET @StyleBOMDimensionID = (SELECT StyleBOMDimensionID FROM pStyleBOMDimension sbd WHERE sbd.WorkflowItemId = @WorkflowItemID)
	ELSE
		SET @StyleBOMDimensionID = @WorkflowItemID

	DECLARE @StyleID UNIQUEIDENTIFIER, @StyleSeasonYearID UNIQUEIDENTIFIER
			
	SELECT @StyleID = StyleID, @StyleSeasonYearID = StyleSeasonYearID
	FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
			
	-- Change Log
	DECLARE @ChangeManagement nVARCHAR(5) = (SELECT UPPER(RTRIM(LTRIM(AppSettingValue))) FROM sAppSetting WHERE AppSettingKey = 'ChangeManagementEnabled')	
	DECLARE @ChangeLog TABLE
	(
		ChangeTableID UNIQUEIDENTIFIER
		, ChangeTablePKID UNIQUEIDENTIFIER
		, ChangeFieldName NVARCHAR(200)
		, ChangeFieldAlias NVARCHAR(200)
		, ChangeBeforeValue NVARCHAR(200)
		, ChangeAfterValue NVARCHAR(200)
		, ChangeBeforeText NVARCHAR(4000)
		, ChangeAfterText NVARCHAR(4000)
		, ChangeSubject NVARCHAR(400)
		, ChangeType INT
	)

	IF @ChangeManagement = 'TRUE'
	BEGIN
		DECLARE @AfterText NVARCHAR(200)
		SELECT @AfterText = wfi.WorkFlowItemName 
		FROM pStyleBOMDimension sbd
			INNER JOIN pWorkFlowItem wfi ON sbd.WorkflowItemID = wfi.WorkFlowItemID
		WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
		
		INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
				ChangeSubject, ChangeType)
		SELECT '72121996-7A96-4C27-BE25-9C7B4A5AED37', pli.PlanningID, 'PlanningID', sh.StyleNo + ' - Bill Of Material',
				pli.StyleBOMDimensionID, @StyleBOMDimensionID, wfi.WorkFlowItemName, @AfterText, '', 0
		FROM pPlanningItem pli
		INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
		LEFT JOIN pStyleBOMDimension sbd
			INNER JOIN pWorkFlowItem wfi ON sbd.WorkflowItemID = wfi.WorkFlowItemID
		ON pli.StyleBOMDimensionID = sbd.StyleBOMDimensionID
		WHERE pli.PlanningItemID = @PlanningItemID
	END

	UPDATE pPlanningItem SET StyleBOMDimensionID = @StyleBOMDimensionID WHERE PlanningItemID = @PlanningItemID
	
	SELECT * FROM @ChangeLog
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08363', GetDate())
GO
