IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Image')) < 1
BEGIN
	-- Image
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('F1A4FA16-718D-4BFD-B3D2-91A726B4A234', 'Image', 'WebService_Style_Default.xml', 1)
END
GO


-- Image Comment
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Image Comment')) < 1
BEGIN
	-- Style Design Detail
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('F1A4FA16-718D-4BFD-B3D2-91A726B4A234', '7EEE7816-C76F-42CC-883C-FC333E31DEEE', 'Image Comment', '', 1)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06679', GetDate())
GO