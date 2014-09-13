DECLARE @productId TABLE
(
ProductTypeID UNIQUEIDENTIFIER
)
INSERT INTO @productId 
SELECT p1.PermissionProductTypeId AS ProductTypeID FROM sPermissionProductType AS p1 INNER JOIN sPermissionProductType AS p2 
			ON p1.PermissionFolderId = p2.PermissionFolderId 
			AND p1.PermissionProductTypeMapId = p2.PermissionProductTypeMapId
			AND p1.GroupId = p2.GroupId
			AND p1.PermissionProductTypeName = p2.PermissionProductTypeName
WHERE p1.PermissionProductTypeId > p2.PermissionProductTypeId

-- delete workflows
DELETE w FROM sPermissionWorkflow AS w
INNER JOIN @productId AS p ON w.PermissionProductTypeId = p.ProductTypeID
-- delete producttypes
DELETE p1 FROM sPermissionProductType AS p1
INNER JOIN @productId AS p2 ON p1.PermissionProductTypeId = p2.ProductTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08153', GetDate())
GO
