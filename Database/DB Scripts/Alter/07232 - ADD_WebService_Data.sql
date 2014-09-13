IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Sample')) < 1
BEGIN
	
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'Sample', '', 1)
END
GO



IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Submit Fit Video')) < 1
BEGIN

	INSERT INTO sWebServiceItem(WebServiceID,  WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'Sample Request Submit Fit Video', '', 1)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07232', GetDate())
GO