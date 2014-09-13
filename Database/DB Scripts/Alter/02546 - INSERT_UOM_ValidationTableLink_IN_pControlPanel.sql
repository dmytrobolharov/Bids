
IF EXISTS(SELECT ControlPanelID FROM [pControlPanel] WHERE [ControlPanelTableName]='UOM' AND [IsDataValidation]=0)
BEGIN
	DELETE FROM [pControlPanel] WHERE [ControlPanelTableName]='UOM' AND [IsDataValidation]=0	
END

IF NOT EXISTS(SELECT ControlPanelID FROM [pControlPanel] WHERE [ControlPanelTableName]='UOM' AND [IsDataValidation]=0)
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
		[SPXLogicInsert],
		[SPXLogicUpdate],
		[ControlPanelTypeID],
		[ControlPanelRepId],
		[IsDataValidation]
	) 
	VALUES 
	(
		@MaxControlPanelID, 
		N'UOM', 
		N'Unit Of Measurement', 
		@MaxControlPanelOrder, 
		NULL, 
		N'Control_Custom_UOM_Default.xml', 
		N'Control_Custom_UOM_Search.xml', 
		N'UOM', 
		N'Control_Custom_List.aspx?CPID='+CONVERT(VARCHAR(10),@MaxControlPanelID)+'', 
		NULL, 
		NULL, 
		NULL, 
		N'ecc16935-3677-e011-8802-000c29807141', 
		N'2c2eab78-6865-4363-b242-99c262dbd054', 
		0
	)

END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02546'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02546', GetDate())
END
GO