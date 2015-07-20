-- Reset the perms on a particular WebServiceClient

EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000011'	-- Tech Pack Services
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000012'	-- Style API Services
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000013'	-- Adobe Integration Services
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000014'	-- iOS iPhone
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000015'	-- iOS iPad
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000016'	-- Android Phone
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000017'	-- Android Tablet
EXEC spx_Grant_Full_WebService_Perms '40000000-0000-0000-0000-000000000018'	-- YuniquePLM Toolkit
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09075', GetDate())
GO