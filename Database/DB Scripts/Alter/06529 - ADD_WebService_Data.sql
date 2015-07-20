IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Sample')) < 1
BEGIN
	-- Sample
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'Sample', '', 1)
END
GO


-- Sample Request Style Seasonal
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Style Seasonal')) < 1
BEGIN
	-- Sample Request Style Seasonal
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '7EEE7816-C76F-426C-8836-FA386E31D333', 'Sample Request Style Seasonal', '', 1)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06529', GetDate())
GO