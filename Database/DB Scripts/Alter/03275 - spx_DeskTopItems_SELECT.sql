/****** Object:  StoredProcedure [dbo].[spx_DeskTopItems_SELECT]    Script Date: 03/29/2012 17:48:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTopItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTopItems_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTopItems_SELECT]    Script Date: 03/29/2012 17:48:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskTopItems_SELECT]
	@TeamID UNIQUEIDENTIFIER,
	@Design INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	IF NOT EXISTS(SELECT * FROM uUserSetting WHERE TeamID = @TeamID AND (SettingSection = 'DeskTopItems' OR SettingSection = 'DeskMenuItems'))
	BEGIN
		INSERT INTO uUserSetting(TeamID, SettingSection, SettingKey, SettingValue)
		SELECT @TeamID, 'DeskTopItems', DeskSort, DeskTopID
		FROM sDeskTop
		ORDER BY DeskSort
	END
	
	CREATE TABLE #tmpDeskTop (		
		DeskAccessId INT NULL,
		DeskFolderID INT NULL,
		DeskTopID INT NOT NULL,
		DeskName NVARCHAR(100) NULL,
		DeskDescription NVARCHAR(4000) NULL,
		DeskIcon VARCHAR(200) NULL,
		DeskLabel1 NVARCHAR(25) NULL,
		DeskLabel2 NVARCHAR(25) NULL,
		DeskButtonName VARCHAR(50) NULL,
		DeskUrl VARCHAR(400) NULL,
		DeskMenu VARCHAR(400) NULL,
		DeskMain VARCHAR(400) NULL,
		DeskSort VARCHAR(4) NULL,
		DeskActive INT NOT NULL,
		Sort INT NOT NULL,
		ExtraSort INT NOT NULL
	)
	
	IF @Design = 0
	BEGIN
		INSERT INTO #tmpDeskTop(DeskAccessId, DeskFolderID, DeskTopID, DeskName, 
			DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskButtonName, 
			DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, Sort, ExtraSort)
		SELECT  
			1000 AS 'DeskAccessId',
			1001 AS 'DeskFolderID',
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
			CAST(a.DeskSort AS INT) as Sort,
			0 AS ExtraSort
		FROM  
			sDeskTop a 
		WHERE 
			a.DeskName In('Home')
	END		
	
	INSERT INTO #tmpDeskTop(DeskAccessId, DeskFolderID, DeskTopID, DeskName, 
		DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskButtonName, 
		DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, Sort, ExtraSort)
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
		CAST(s.SettingKey AS INT) as Sort,
		5 AS ExtraSort
	FROM  
		sDeskTop a
		INNER JOIN uUserSetting s ON a.DeskTopID = CAST(s.SettingValue AS INT)
	WHERE 
		a.DeskName In('Log Off', 'Admin', 'Profile')
		AND s.SettingSection = 'DeskTopItems'
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
		CAST(s.SettingKey AS INT) AS Sort,
		5 AS ExtraSort
	FROM 
		uUserGroup a WITH (NOLOCK)
		INNER JOIN uGroup b WITH (NOLOCK) ON a.GroupID = b.GroupID
		INNER JOIN cDeskGroupFolderAccess c WITH (NOLOCK) ON c.GroupID = b.GroupID		
		INNER JOIN sDeskTop d ON c.DeskFolderId = d.DeskFolderID
		INNER JOIN uUserSetting s ON CAST(s.SettingValue AS INT) = d.DeskTopID
	WHERE 		  
		b.Active = 1
		AND s.TeamID = @TeamID
		AND s.SettingSection = 'DeskTopItems'
		AND d.DeskActive = 1 AND c.DeskAccessId = 1
		AND a.TeamID = @TeamId 
	GROUP BY 
		c.DeskAccessId,
		c.DeskFolderID,
		d.DeskTopID, 
		d.DeskName, 
		d.DeskDescription, 
		d.DeskIcon,
		d.DeskLabel1, 
		d.DeskLabel2, 
		d.DeskUrl, 
		d.DeskMenu, 
		d.DeskMain,
		d.DeskSort, 
		d.DeskActive,
		d.DeskButtonName, 
		s.SettingKey
	ORDER BY 
		Sort, DeskSort
			
	SELECT * FROM #tmpDeskTop ORDER BY ExtraSort, Sort, DeskSort
	
	DROP TABLE #tmpDeskTop
	
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03275'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03275', GetDate())

END
GO 