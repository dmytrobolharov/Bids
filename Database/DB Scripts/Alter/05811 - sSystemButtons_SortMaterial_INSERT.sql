IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString='btn_sort_materials.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_sort.gif', 'btn_sort_materials.gif', 'sort material')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05811', GetDate())
GO
