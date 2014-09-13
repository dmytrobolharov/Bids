/****** Object:  StoredProcedure [dbo].[spx_DeskMenuItems_SELECT]    Script Date: 03/29/2012 17:49:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskMenuItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskMenuItems_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskMenuItems_SELECT]    Script Date: 03/29/2012 17:49:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskMenuItems_SELECT]
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT  
		1000 'DeskAccessId',
		1001 'DeskFolderID',
		a.DeskTopID, 
		a.DeskName, 
		a.DeskDescription, 
		a.DeskIcon,
		a.DeskLabel1, 
		a.DeskLabel2,
		a.DeskButtonName, 
		a.DeskUrl, 
		a.DeskMenu, 
		a.DeskMain,
		a.DeskSort, 
		a.DeskActive,
		CAST(s.SettingKey AS INT) as Sort
	FROM  
		sDeskTop a
		INNER JOIN uUserSetting s ON a.DeskTopID = CAST(s.SettingValue AS INT)
	WHERE 
		a.DeskName In('Log Off', 'Admin', 'Profile')
		AND s.SettingSection = 'DeskMenuItems'
		AND s.TeamID = @TeamID
		AND a.DeskActive = 1

	UNION
	
	SELECT 
		c.DeskAccessId,
		c.DeskFolderID,
		d.DeskTopID, 
		d.DeskName, 
		d.DeskDescription,
		d.DeskIcon,
		d.DeskLabel1, 
		d.DeskLabel2,
		d.DeskButtonName,
		d.DeskUrl, 
		d.DeskMenu, 
		d.DeskMain,
		d.DeskSort, 
		d.DeskActive,
		CAST(s.SettingKey AS INT) AS Sort
	FROM 
		uUserGroup a WITH (NOLOCK)
		INNER JOIN uGroup b WITH (NOLOCK) ON a.GroupID = b.GroupID
		INNER JOIN cDeskGroupFolderAccess c WITH (NOLOCK) ON c.GroupID = b.GroupID		
		INNER JOIN sDeskTop d ON c.DeskFolderId = d.DeskFolderID
		INNER JOIN uUserSetting s ON CAST(s.SettingValue AS INT) = d.DeskTopID
	WHERE 		  
		b.Active = 1
		AND s.TeamID = @TeamID
		AND s.SettingSection = 'DeskMenuItems'
		AND d.DeskActive = 1 AND c.DeskAccessId = 1
		AND a.TeamID = @TeamId 	
	ORDER BY 
		Sort, DeskSort
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03276'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03276', GetDate())

END
GO

