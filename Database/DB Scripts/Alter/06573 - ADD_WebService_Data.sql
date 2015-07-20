IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Color')) < 1
BEGIN
	-- Color
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('1EDC9B2E-A630-48BA-8997-CF858858DC60', 'Color', '', 1)
END
GO


-- Color Request Style Seasonal
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Color Season Year')) < 1
BEGIN
	-- Color Request Style Seasonal
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('1EDC9B2E-A630-48BA-8997-CF858858DC60', '7EEE7816-CCEF-426C-8836-FA386E31D333', 'Color Season Year', '', 1)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06573', GetDate())
GO