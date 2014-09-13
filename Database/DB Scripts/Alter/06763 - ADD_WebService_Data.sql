IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Material')) < 1
BEGIN
	-- Image
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('60C71021-CBFB-4E2C-A68A-C872F90A6F93', 'Material', 'WebService_Material_Default.xml', 1)
END
GO


-- Image Comment
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Material Comment')) < 1
BEGIN
	-- Style Design Detail
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('60C71021-CBFB-4E2C-A68A-C872F90A6F93', '7EEE7FFF-C76F-42CC-883C-FC333E31DEEE', 'Material Comment', '', 1)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06763', GetDate())
GO