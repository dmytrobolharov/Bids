IF EXISTS (SELECT * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Machinery'))
BEGIN
	UPDATE pControlPanel SET ControlPanelEditSchema = 'Control_NBOL_Machinery_Edit_Default.xml' WHERE UPPER(ControlPanelName) = UPPER('Machinery')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03559', GetDate())
GO