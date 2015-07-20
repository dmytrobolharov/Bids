BEGIN 

	DECLARE @NewControlPanelTypeID AS UNIQUEIDENTIFIER
	DECLARE @nSort as int 
	DECLARE @nMax as int 
	DECLARE @nCount as int
	DECLARE @vcCount as varchar (5)

	SET @NewControlPanelTypeID = NEWID()

	IF NOT EXISTS (SELECT * FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) IN ('VALIDATION TABLES', 'VALIDATION'))
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
		VALUES (@NewControlPanelTypeID, N'Validation tables', N'Validation tables', NULL, NULL, NULL, NULL, 1, @vcCount)


		IF EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'DATA VALIDATION')
		BEGIN
			UPDATE pControlPanel SET ControlPanelTypeID = @NewControlPanelTypeID WHERE UPPER(ControlPanelName) = 'DATA VALIDATION' AND ControlPanelTypeID IS NULL
		END

		IF EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'SEASON')
		BEGIN
			UPDATE pControlPanel SET ControlPanelTypeID = @NewControlPanelTypeID WHERE UPPER(ControlPanelName) = 'SEASON' AND ControlPanelTypeID IS NULL
		END

		IF EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'YEAR')
		BEGIN
			UPDATE pControlPanel SET ControlPanelTypeID = @NewControlPanelTypeID WHERE UPPER(ControlPanelName) = 'YEAR' AND ControlPanelTypeID IS NULL
		END

		IF EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'INTRO SEASON YEAR')
		BEGIN
			UPDATE pControlPanel SET ControlPanelTypeID = @NewControlPanelTypeID WHERE UPPER(ControlPanelName) = 'INTRO SEASON YEAR' AND ControlPanelTypeID IS NULL
		END

	END


END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03672', GetDate())
GO