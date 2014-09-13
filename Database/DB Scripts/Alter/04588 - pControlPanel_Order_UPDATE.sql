Declare @ControlPanelOrder int
Declare @ControlPanelID int
Declare @ControlPanelTypeId uniqueidentifier

SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) FROM pControlPanel WHERE ControlPanelName like 'machine%' and ControlPanelSchema like '%NBOL%'

-- set Operation Library after Machinery
UPDATE pControlPanel SET ControlPanelOrder = (CAST(ControlPanelOrder as int) - 1) WHERE ControlPanelName like 'machine%' and ControlPanelSchema like '%NBOL%'
UPDATE pControlPanel SET ControlPanelOrder = @ControlPanelOrder WHERE ControlPanelName = 'Operation Library'

-- insert Exchange rate
IF NOT EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName = 'Exchange Rate')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel WHERE ControlPanelTypeID = '09773e42-5ab8-e011-9f63-544c92f24f0d'
	IF @ControlPanelOrder = 1
		SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  FROM pControlPanel
	
	INSERT INTO pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
			 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) VALUES
	(@ControlPanelID,'Exchange Rate','Exchange Rate',@ControlPanelOrder,'sExchangeRate','Control_Custom_ExchangeRate_Default.xml',
			'Control_Custom_ExchangeRate_Search.xml', 'Control_Custom_ExchangeRateEdit_Default.xml', 'Control_ExchangeRate_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), NULL)
END
ELSE
BEGIN
	
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel WHERE ControlPanelTypeID = '09773e42-5ab8-e011-9f63-544c92f24f0d'
	IF @ControlPanelOrder = 1
		SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  FROM pControlPanel
		
	UPDATE pControlPanel SET ControlPanelOrder = @ControlPanelOrder WHERE ControlPanelName = 'Exchange Rate'
	
END
GO

-- put Exchange rate to BOL v.2 folder
IF EXISTS (SELECT * FROM pControlPanelType WHERE ControlPanelTypeID = '09773e42-5ab8-e011-9f63-544c92f24f0d')
BEGIN
	UPDATE pControlPanel SET ControlPanelTypeID = '09773e42-5ab8-e011-9f63-544c92f24f0d' WHERE ControlPanelName = 'Exchange Rate'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04588', GetDate())
GO
