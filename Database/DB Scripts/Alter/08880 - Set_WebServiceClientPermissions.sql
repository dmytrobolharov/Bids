
-- Reset the perms on a particular WebServiceClient
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000018'
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000011'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08880', GetDate())
GO
