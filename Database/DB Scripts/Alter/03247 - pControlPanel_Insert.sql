
begin
	Declare @ControlPanelID int
	Declare @ControlPanelOrder int
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Ship Type')
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelUrl) values
		(@ControlPanelID,'Ship Type','Ship Type',@ControlPanelOrder,'pSourceShipType','Control_SourceShipType_Default.xml',
				'Control_SourceShipType_Search.xml','Control_Custom_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),@ControlPanelID))
	end
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Ship Mode')
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelUrl) values
		(@ControlPanelID,'Ship Mode','Ship Mode',@ControlPanelOrder,'pSourceShipMode','Control_SourceShipMode_Default.xml',
				'Control_SourceShipMode_Search.xml', 'Control_Custom_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),@ControlPanelID))
	end
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Trade Point')
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelUrl) values
			(@ControlPanelID,'Trade Point','Trade Point',@ControlPanelOrder,'pSourceTradePoint','Control_SourceTradePoint_Default.xml',
				'Control_SourceTradePoint_Search.xml', 'Control_Custom_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),@ControlPanelID))
	end
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Partner Type')
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelUrl) values
		(@ControlPanelID,'Partner Type','Partner Type',@ControlPanelOrder,'uTradePartnerRelationshipType','Control_TradePartnerRelationshipType_Default.xml',
				'Control_TradePartnerRelationshipType_Search.xml', 'Control_PartnerType_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),@ControlPanelID))
	end	
	
end
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03247'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03247', GetDate())

END

GO