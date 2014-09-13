IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_UserGroupDropDown_SEL]'))
DROP VIEW [dbo].[vwx_UserGroupDropDown_SEL]
GO

CREATE VIEW [dbo].[vwx_UserGroupDropDown_SEL]
AS


SELECT	0 AS UserID, 
		NULL AS FullName, 
		NULL AS FirstName, 
		NULL AS Company, 
		1 AS UserType

UNION

SELECT	UserID, 
		ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') AS FullName, 
		FirstName, 
		Company, 
		2 AS UserType
FROM Users 
WHERE Active = '1' AND TradePartner = 0

UNION

SELECT	WorkflowGroupID AS UserID, 
		ISNULL(GroupName,'') + ' (' + ISNULL(GroupDescription,'') + ')' AS FullName, 
		GroupName AS FirtName, 
		NULL AS Company, 
		1 AS UserType
FROM uGroup
WHERE Active = '1'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06322', GetDate())
GO
