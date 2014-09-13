
begin
	Declare @ControlPanelID int
	Declare @ControlPanelOrder int
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Season Calendar')
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelUrl) values
		(@ControlPanelID,'Season Calendar','Season Calendar',@ControlPanelOrder,'pSeasonCalendar','Control_SeasonCalendar_Default.xml',
				'Control_SeasonCalendar_Search.xml', 'Control_SeasonCalendar_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),@ControlPanelID))
	end	
	
end
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03248'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03248', GetDate())

END

GO