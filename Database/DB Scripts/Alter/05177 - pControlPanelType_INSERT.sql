BEGIN 

	DECLARE @NewControlPanelTypeID AS UNIQUEIDENTIFIER
	DECLARE @nSort as int 
	DECLARE @nMax as int 
	DECLARE @nCount as int
	DECLARE @vcCount as varchar (5)

	SET @NewControlPanelTypeID = NEWID()

	IF NOT EXISTS (SELECT * FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) IN ('SOURCING FOLDER'))
	BEGIN

		SELECT @nCount = count(*) FROM pControlPanelType
		SELECT @nMax = cast (MAX (Sort) as int) FROM pControlPanelType
		IF @nCount IS NULL SET @nCount = 0 
		IF @nMax IS NULL SET @nMax = 0 
		IF @nCount > @nMax 	SET @nSort = @nCount 
		ELSE SET @nSort = @nMax 
		
		SET @nSort = @nSort + 1
		SET @vcCount =  RIGHT ( '000' +  cast ( @nSort as varchar (5) ) , 3 )

		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate],[Active], [Sort]) 
		VALUES (@NewControlPanelTypeID, N'Sourcing Folder', N'Sourcing Folder', NULL, NULL, NULL, NULL, 1, @vcCount)


		IF EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'SOURCING TYPES')
		BEGIN
			UPDATE pControlPanel SET ControlPanelTypeID = @NewControlPanelTypeID WHERE UPPER(ControlPanelName) = 'Sourcing Types' AND ControlPanelTypeID IS NULL
		END

		
		IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'SOURCING TYPES')
		BEGIN

			INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [IsDataValidation], [ControlPanelTypeID]) 
			SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
				   'Sourcing Types', 
				   'Sourcing Types', 
				   COALESCE(MAX(ControlPanelOrder),0) + 1, 
				   'Control_SourcingTypes_Default.xml', 
				   'Control_SourcingTypes_Search.xml', 
				   'pSourcingType',
				   'Control_SourcingTypes.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),
				   'Control_SourcingTypes_Edit.xml',
				   0,
				   @NewControlPanelTypeID
			FROM pControlPanel

		END
		
	END


END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05177', GetDate())
GO