IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Style')) < 1
BEGIN
	-- Style
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', 'Style', 'WebService_Style_Default.xml', 1)
END
GO


-- Style Design Detail
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Style Quote Comment')) < 1
BEGIN
	-- Style Design Detail
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', '7E4DD822-C76F-426C-8836-FA386E31DEEE', 'Style Quote Comment', '', 1)
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06874', GetDate())
GO