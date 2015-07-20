 IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Team and Group')) < 1
BEGIN
       -- Authorization service
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('D8ADF7C0-3DB4-4EAF-92BE-EC5A44E999F4', 'Team and Group', '', 1)
END
GO

-- User services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('User')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('D8ADF7C0-3DB4-4EAF-92BE-EC5A44E999F4', 'User', '', 1)
END

GO

SET NOCOUNT Off
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07678', GetDate())
GO
