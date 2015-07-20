IF (SELECT COUNT(WebServiceItemName)
	  FROM sWebServiceItem
	 WHERE UPPER(WebServiceItemName) = UPPER('Line List Quick Fill')
	   and WebServiceItemDefaultSchema = '') < 1
BEGIN
	-- Style BOM Dimension
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E77B', NEWID(), 'Line List Quick Fill', '', 1)

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06192', GetDate())
GO