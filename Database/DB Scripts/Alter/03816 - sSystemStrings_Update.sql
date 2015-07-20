update sSystemStrings set DesignString='Image Where Used' where DesignString='Image Where used'
update sSystemStrings set DesignString='Image Where Used in Styles' where DesignString='Image where used in Styles'
update sSystemStrings set DesignString='Image Folder (Where Used)' where DesignString='Image Folder (Where used)'
update sSystemStrings set DesignString='Image Where Used in Materials' where DesignString='Image where used in Materials'
update sSystemStrings set DesignString='Image Where Used in Image Catalogs' where DesignString='Image where used in Image Catalogs'
update sSystemStrings set DesignString='Image Where Used in Material Groups' where DesignString='Image where used in Material Groups'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03816', GetDate())
GO
