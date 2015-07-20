/****** Object:  StoredProcedure [dbo].[spx_ColorTypeDataTable_SELECT]    Script Date: 06/05/2014 11:46:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorTypeDataTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorTypeDataTable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorTypeDataTable_SELECT]    Script Date: 06/05/2014 11:46:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ColorTypeDataTable_SELECT]
@TeamID AS NVARCHAR(50)
AS 

BEGIN

	SELECT 
		ColorTypeID, 
		ColorTypeDescription 
	FROM 
		pColorType col
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7) access
		ON col.ColorTypeID = access.ProductTypeId
	WHERE
		access.PermissionRoleId = 3 OR access.PermissionView = 1
	ORDER BY
		ColorTypeID,
		ColorTypeDescription

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07902', GetDate())
GO
