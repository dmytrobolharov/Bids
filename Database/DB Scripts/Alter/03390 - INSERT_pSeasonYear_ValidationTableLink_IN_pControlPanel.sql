IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSeasonYear' and COLUMN_NAME = N'CUSTOM')
       BEGIN 
             ALTER TABLE pSeasonYear ADD CUSTOM NVARCHAR(50) NULL
       END
GO

IF EXISTS(SELECT ControlPanelID FROM [pControlPanel] WHERE [ControlPanelTableName]='pSeasonYear')
BEGIN
	DELETE FROM [pControlPanel] WHERE [ControlPanelTableName]='pSeasonYear' 
END

IF NOT EXISTS(SELECT ControlPanelID FROM [pControlPanel] WHERE [ControlPanelTableName]='pSeasonYear')
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
		N'Intro Season Year', 
		N'Intro Season Year', 
		@MaxControlPanelOrder, 
		NULL, 
		N'Control_pSeasonYear_Default.xml', 
		N'Control_pSeasonYear_Search.xml', 
		N'pSeasonYear', 
		N'Control_Custom_List.aspx?CPID='+CONVERT(VARCHAR(10),@MaxControlPanelID)+'', 
		NULL, 
		NULL
	)
END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03390', GetDate())

GO




