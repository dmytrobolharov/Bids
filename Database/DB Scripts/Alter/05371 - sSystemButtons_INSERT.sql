if NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_planning_values.gif')
begin
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_edit_file.gif', 'btn_planning_values.gif', 'planning values')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05371', GetDate())
GO
