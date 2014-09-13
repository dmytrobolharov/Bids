-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 June 2014                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[spx_Group_ProductPermissionsOnFolder_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [spx_Group_ProductPermissionsOnFolder_SELECT]
GO

CREATE PROCEDURE [spx_Group_ProductPermissionsOnFolder_SELECT]
	@GroupID uniqueidentifier,
	@FolderID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--select * from sPermissionProductType as product where product.PermissionFolderId = @FolderID and product.GroupId = @GroupID
	SELECT product.*, map.GuidProductTypeId, map.IntProductTypeId, map.StrProductTypeId, map.PermissionFolderTypeId
	FROM sPermissionProductType product
	INNER JOIN sPermissionProductTypeMap map ON product.PermissionProductTypeMapId = map.PermissionProductTypeMapId
	WHERE product.GroupId = @GroupID
	AND product.PermissionFolderId = @FolderID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07998', GetDate())
GO
