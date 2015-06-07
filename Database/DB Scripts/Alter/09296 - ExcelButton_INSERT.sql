IF NOT EXISTS (SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_excel_export.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_excel_export.gif', 'Excel export', '16x16_excel.png')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09296', GetDate())
GO
