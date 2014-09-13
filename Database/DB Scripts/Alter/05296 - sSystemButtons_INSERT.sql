if NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_ExcelUpload.gif')
begin
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('ext_xls.gif', 'btn_ExcelUpload.gif', 'Upload Excel')
end
GO

if NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_ExcelImport.gif')
begin
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('ext_xls.gif', 'btn_ExcelImport.gif', 'Import Excel')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05296', GetDate())