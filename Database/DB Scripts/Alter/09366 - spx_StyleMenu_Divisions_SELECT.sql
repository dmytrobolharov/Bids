/****** Object:  StoredProcedure [dbo].[spx_StyleMenu_Divisions_SELECT]    Script Date: 17.02.2015 11:21:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMenu_Divisions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMenu_Divisions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMenu_Divisions_SELECT]    Script Date: 17.02.2015 11:21:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	Stanislav Stepanchenko
-- Create date: 02/17/2015
-- Description:	Gets the division list for Styles Menu
-- =============================================
CREATE PROCEDURE [dbo].[spx_StyleMenu_Divisions_SELECT]
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT division.CustomID, division.Custom 
	FROM vwx_Division_SEL division
	INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 26) access ON access.ProductTypeId = division.CustomID
	WHERE Active = 1 AND access.PermissionRoleId > 0
	ORDER BY CustomSort, Custom
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09366', GetDate())
GO