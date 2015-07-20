IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Team and Group')) < 1
BEGIN
	-- Team and Group
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('D8ADF7C0-3DB4-4EAF-92BE-EC5A44E999F4', 'Team and Group', '', 1)
END
GO


-- Sample Request Style Seasonal
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('User Preference')) < 1
BEGIN
	-- Sample Request Style Seasonal
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('D8ADF7C0-3DB4-4EAF-92BE-EC5A44E999F4', '7EEE7816-C76F-426C-8836-FA3D6E3DD444', 'User Preference', '', 1)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07494', GetDate())
GO