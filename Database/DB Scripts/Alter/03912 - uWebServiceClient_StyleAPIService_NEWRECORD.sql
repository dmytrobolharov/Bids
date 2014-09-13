IF (NOT EXISTS(SELECT WSClientID FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000012'))
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000012', 'Style API Services', 'Test', 'TestPassword', 1)
END


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03912'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03912', GetDate())
END
GO