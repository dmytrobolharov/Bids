 IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('ProxyRest')) < 1
BEGIN
       -- ProxyRest service
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('BE1720B4-8061-4B1B-40EA-C13BE58B72EA', 'ProxyRest', '', 1)
END
GO

-- ProxyRest services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('ProxyRest')) < 1 
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8061-4B1B-40EA-C13BE58B72EA', 'ProxyRest', '', 1)
END
GO

SET NOCOUNT Off
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07675', GetDate())
GO
