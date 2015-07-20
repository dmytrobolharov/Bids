 IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Authorization')) < 1
BEGIN
       -- Authorization service
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'Authorization', '', 1)
END
GO

-- Groups services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Groups')) < 1 
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'Groups', '', 1)
END
GO

-- UserGroup services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('UserGroup')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'UserGroup', '', 1)
END
GO

-- CheckFolderTypeByTeamId services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('CheckFolderTypeByTeamId')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'CheckFolderTypeByTeamId', '', 1)
END
GO

-- CheckFolderByTeamId services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('CheckFolderByTeamId')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'CheckFolderByTeamId', '', 1)
END
GO

-- CheckFolderByGroup services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('CheckFolderByGroup')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'CheckFolderByGroup', '', 1)
END
GO

-- CheckFolderTypeGroup services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('CheckFolderTypeGroup')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'CheckFolderTypeGroup', '', 1)
END
GO

-- LockFolder services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('LockFolder')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'LockFolder', '', 1)
END

GO

-- UnlockFolder services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('UnlockFolder')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'UnlockFolder', '', 1)
END

GO

-- ModifyWorkflow services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('ModifyWorkflow')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'ModifyWorkflow', '', 1)
END

GO

-- Folder services
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Folder')) < 1
BEGIN       
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-45EA-C13BE58B72EA', 'Folder', '', 1)
END

GO

SET NOCOUNT Off
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07674', GetDate())
GO
