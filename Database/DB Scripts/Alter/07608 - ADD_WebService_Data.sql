IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('T&A Calendar')) < 1
BEGIN
	
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('56B9ADDB-B6AF-4380-94D7-70588DDDED7B', 'T&A Calendar', '', 1)
END
GO



IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('TACalendarTemplateTask')) < 1
BEGIN
	
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('56B9ADDB-B6AF-4380-94D7-70588DDDED7B', '5EDFDEC5-E2DF-4CCC-8333-7FB36F650353', 'TACalendarTemplateTask', '', 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07608', GetDate())
GO