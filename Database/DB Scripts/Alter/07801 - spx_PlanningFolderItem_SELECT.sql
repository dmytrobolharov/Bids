IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningFolderItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningFolderItem_SELECT]
	@PlanningFolderTypeID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT '00000000-0000-0000-0000-000000000009' AS PlanningItemID, 'Merchandise Plan' AS PlanningItemName, 
		'Merchandise Plan' AS PlanningItemDescription, -1 AS PlanningItemSort, '0' As Child
		UNION
    SELECT '00000000-0000-0000-0000-000000000001' AS PlanningItemID, 'Financial Plan' AS PlanningItemName, 
		'Financial Plan' AS PlanningItemDescription, 0 AS PlanningItemSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000002' AS PlanningItemID, 'Development Tracker' AS PlanningItemName, 
		'Development Tracker' AS PlanningItemDescription, 1 AS PlanningItemSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000003' AS PlanningItemID, 'SKU Plan' AS PlanningItemName, 
		'SKU Plan' AS PlanningItemDescription, 2 AS PlanningItemSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000004' AS PlanningItemID, 'Line List Plan' AS PlanningItemName, 
		'Line List Plan' AS PlanningItemDescription, 3 AS PlanningItemSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000005' AS PlanningItemID, 'Color Plan' AS PlanningItemName, 
		'Color Plan' AS PlanningItemDescription, 4 AS PlanningItemSort, '0' As Child
		UNION	
	SELECT '00000000-0000-0000-0000-000000000006' AS PlanningItemID, 'Flash Edit' AS PlanningItemName, 
		'Flash Edit' AS PlanningItemDescription, 5 AS PlanningItemSort, '0' As Child
		UNION		
    SELECT PlanningFlashEditId AS PlanningItemID, PlanningFlashEditName AS PlanningItemName, 
			PlanningFlashEditDescription AS PlanningItemDescription, PlanningFlashEditSort+5 AS PlanningItemSort, '1' As Child
			FROM pPlanningFlashEdit
		UNION		
	SELECT '00000000-0000-0000-0000-000000000007' AS PlanningItemID, 'Material Plan' AS PlanningItemName, 
		'Material Plan' AS PlanningItemDescription, 100 AS PlanningItemSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000008' AS PlanningItemID, 'BI' AS PlanningItemName,
		'BI' AS PlanningItemDescription, 101 AS PlanningItemSort, '0' As Child
		UNION
	SELECT dfi.DashFolderItemID AS PlanningItemID, dfi.DashFolderItemName AS PlanningItemName, dfi.DashFolderItemName AS LineListFlashEditDescription,
		 DashFolderItemSort+102 As PlanningItemSort, '1' As Child
		 FROM rDashFolderItem dfi INNER JOIN rDashFolder df ON dfi.DashFolderID = df.DashFolderID WHERE df.DashFolderName = 'Planning'
	ORDER BY PlanningItemSort
END



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07801', GetDate())
GO

