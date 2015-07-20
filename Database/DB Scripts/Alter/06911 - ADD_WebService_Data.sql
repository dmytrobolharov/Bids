IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Material Request')) < 1
BEGIN
	-- Image
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('60C71021-CBFB-4E2C-A68A-C872BAAA6F93', 'Material Request', 'WebService_Material_Default.xml', 1)
END
GO


-- Image Comment
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Material Request Comment')) < 1
BEGIN
	-- Style Design Detail
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('60C71021-CBFB-4E2C-A68A-C872BAAA6F93', '7EEE7FFF-C7DD-42CC-883C-FC333E3DDEEE', 'Material Request Comment', '', 1)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06911', GetDate())
GO