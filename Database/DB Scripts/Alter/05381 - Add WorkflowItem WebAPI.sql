


IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Workflow')) < 1
BEGIN
       -- Workflow
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES (NEWID(), 'Workflow', '', 1)
END

IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Workflow')) >= 1
BEGIN
	declare @webServiceID nvarchar(max)
		set @webServiceID = (select WebServiceID from sWebService where UPPER(WebServiceName) = UPPER('Workflow'))
		
		IF (SELECT COUNT(WebServiceItemName)
              FROM sWebServiceItem
              WHERE UPPER(WebServiceItemName) = UPPER('Workflow Item')) < 1
		BEGIN
			-- Workflow Item
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Workflow Item', 'WorkflowItem_Default.xml', 1)
       
		END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05381', GetDate())
GO


