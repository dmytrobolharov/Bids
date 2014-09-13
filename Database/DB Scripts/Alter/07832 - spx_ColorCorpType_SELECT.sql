/****** Object:  StoredProcedure [dbo].[spx_ColorCorpType_SELECT]    Script Date: 06/03/2014 16:30:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorCorpType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorCorpType_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorCorpType_SELECT]    Script Date: 06/03/2014 16:30:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE  [dbo].[spx_ColorCorpType_SELECT](
@TeamID UNIQUEIDENTIFIER 
)
AS
 
BEGIN
	SELECT * FROM pColorType
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7) access ON pColorType.ColorTypeID = access.ProductTypeId
	WHERE PermissionRoleId <> 0
	AND CorpColor = 1
	ORDER BY Sort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07832', GetDate())
GO