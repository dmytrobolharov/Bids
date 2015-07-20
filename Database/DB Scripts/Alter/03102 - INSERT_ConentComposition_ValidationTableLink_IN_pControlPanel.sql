
IF EXISTS(SELECT ControlPanelID FROM [pControlPanel] WHERE [ControlPanelTableName]='pMaterialContentType')
BEGIN
	DELETE FROM [pControlPanel] WHERE [ControlPanelTableName]='pMaterialContentType' 
END

IF NOT EXISTS(SELECT ControlPanelID FROM [pControlPanel] WHERE [ControlPanelTableName]='pMaterialContentType')
BEGIN 
	
	DECLARE @MaxControlPanelID AS INT
	SET @MaxControlPanelID=0
	DECLARE @MaxControlPanelOrder AS INT
	SET @MaxControlPanelOrder=0
	
	SELECT 
		@MaxControlPanelID=ISNULL(MAX(ControlPanelID),0)+1,
		@MaxControlPanelOrder=ISNULL(MAX(ControlPanelOrder),0)+1 
	FROM 
		[pControlPanel]	

	INSERT INTO
	[dbo].[pControlPanel] 
	(
		[ControlPanelID], 
		[ControlPanelName], 
		[ControlPanelDescription], 
		[ControlPanelOrder], 
		[ControlPanelIdSchema], 
		[ControlPanelSchema],
		[ControlPanelSearchSchema],
		[ControlPanelTableName],
		[ControlPanelUrl],
		[ControlPanelEditSchema],
		[SPXLogicInsert]
		
	) 
	VALUES 
	(
		@MaxControlPanelID, 
		N'Content Composition', 
		N'Content Composition', 
		@MaxControlPanelOrder, 
		NULL, 
		N'Control_xCustom25_Default.xml', 
		N'Control_xCustom25_Search.xml', 
		N'pMaterialContentType', 
		N'Control_Custom_List.aspx?CPID='+CONVERT(VARCHAR(10),@MaxControlPanelID)+'', 
		NULL, 
		NULL
	)
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03102'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03102', GetDate())
END
GO




