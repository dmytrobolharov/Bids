IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Line List')) < 1
BEGIN
	-- Line List
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E77B', 'Line List', 'WebService_LineList_Default.xml', 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.1.0000', '09153', GetDate())
GO
