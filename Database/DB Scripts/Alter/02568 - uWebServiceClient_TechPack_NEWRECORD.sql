


IF (SELECT COUNT(*) FROM uWebServiceClient WHERE WSClientID = '40000000-0000-0000-0000-000000000011') = 0
BEGIN
	INSERT INTO uWebServiceClient (WSClientID , WSClientName, Username, [Password], Active) 
	VALUES ('40000000-0000-0000-0000-000000000011', 'Tech Pack Services', 'Test', 'TestPassword', 1)
END


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02568'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02568', GetDate())
END
GO