/****** Object:  StoredProcedure [dbo].[spx_DeskTopItems_SELECT]    Script Date: 06/20/2014 18:34:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTopItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTopItems_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTopItems_SELECT]    Script Date: 06/20/2014 18:34:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_DeskTopItems_SELECT]
	@TeamID UNIQUEIDENTIFIER,
	@Design INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	DECLARE @DeskTopItemsCount INT,
			@SettingsItemsCount INT;
			
	SELECT @DeskTopItemsCount = COUNT(*) FROM sDeskTop
	SELECT @SettingsItemsCount = COUNT(*) FROM uUserSetting WHERE TeamID = @TeamID AND (SettingSection = 'DeskTopItems' OR SettingSection = 'DeskMenuItems')
	
	-- on first run or if new desktop items were added
	IF @DeskTopItemsCount > @SettingsItemsCount
	BEGIN
		-- move all except 'control' and 'admin' to top menu
		INSERT INTO uUserSetting(TeamID, SettingSection, SettingKey, SettingValue)
		SELECT @TeamID, 'DeskTopItems', DeskSort, DeskTopID
		FROM sDeskTop
		WHERE (LOWER(DeskName) NOT LIKE '%control%' AND LOWER(DeskName) NOT LIKE '%admin%') 
			AND DeskTopID NOT IN (SELECT CAST(SettingValue AS INT) FROM uUserSetting 
									WHERE TeamID = @TeamID AND (SettingSection = 'DeskTopItems' OR SettingSection = 'DeskMenuItems'))
		ORDER BY DeskSort
		
		-- move 'control' and 'admin' to side menu
		INSERT INTO uUserSetting(TeamID, SettingSection, SettingKey, SettingValue)
		SELECT @TeamID, 'DeskMenuItems', DeskSort, DeskTopID
		FROM sDeskTop
		WHERE (LOWER(DeskName) LIKE '%control%' OR LOWER(DeskName) LIKE '%admin%') 
			AND DeskTopID NOT IN (SELECT CAST(SettingValue AS INT) FROM uUserSetting 
									WHERE TeamID = @TeamID AND (SettingSection = 'DeskTopItems' OR SettingSection = 'DeskMenuItems'))
		ORDER BY DeskSort
	END
	
	CREATE TABLE #tmpDeskTop (		
		DeskAccessId INT NULL,
		DeskFolderID INT NULL,
		DeskTopID INT NOT NULL,
		DeskName NVARCHAR(100) NULL,
		DeskDescription NVARCHAR(4000) NULL,
		DeskIcon nVARCHAR(200) NULL,
		DeskLabel1 NVARCHAR(25) NULL,
		DeskLabel2 NVARCHAR(25) NULL,
		DeskButtonName NVARCHAR(50) NULL,
		DeskUrl NVARCHAR(400) NULL,
		DeskMenu NVARCHAR(400) NULL,
		DeskMain NVARCHAR(400) NULL,
		DeskSort NVARCHAR(4) NULL,
		DeskActive INT NOT NULL,
		Sort INT NOT NULL,
		ExtraSort INT NOT NULL,
		MenuWidth INT NOT NULL
	)
	
	IF @Design = 0
	BEGIN
		INSERT INTO #tmpDeskTop(DeskAccessId, DeskFolderID, DeskTopID, DeskName, 
			DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskButtonName, 
			DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, Sort, ExtraSort, MenuWidth)
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
			0 AS ExtraSort,
			a.MenuWidth
		FROM  
			sDeskTop a 
		WHERE 
			a.DeskName In('Home')
	END		
	
	IF (SELECT Intellimas FROM Users WHERE TeamID = @TeamID) = 1
	BEGIN
		INSERT INTO #tmpDeskTop(DeskAccessId, DeskFolderID, DeskTopID, DeskName, 
			DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskButtonName, 
			DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, Sort, ExtraSort, MenuWidth)
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
			CAST(a.DeskSort AS INT) as Sort,
			5 AS ExtraSort,
			a.MenuWidth
		FROM  
			sDeskTop a		
		WHERE a.DeskName In('Intellimas') AND a.DeskActive = 1
	END
	
	INSERT INTO #tmpDeskTop(DeskAccessId, DeskFolderID, DeskTopID, DeskName, 
		DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskButtonName, 
		DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, Sort, ExtraSort, MenuWidth)
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
		5 AS ExtraSort,
		a.MenuWidth
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
		c.PermissionFolderNotLocked,
		c.PermissionFolderTypeId,
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
		d.DeskSort AS Sort,
		--CAST(s.SettingKey AS INT) AS Sort,
		5 AS ExtraSort,
		d.MenuWidth
	FROM 
		uUserGroup a WITH (NOLOCK)
		INNER JOIN uGroup b WITH (NOLOCK) ON a.GroupID = b.GroupID
		INNER JOIN sPermissionFolder c WITH (NOLOCK) ON c.GroupID = b.GroupID		
		INNER JOIN sDeskTop d ON c.PermissionFolderTypeId = d.DeskFolderID
		INNER JOIN uUserSetting s ON CAST(s.SettingValue AS INT) = d.DeskTopID
	WHERE 		  
		b.Active = 1
		AND s.TeamID = @TeamID
		AND s.SettingSection = 'DeskTopItems'
		AND d.DeskActive = 1 AND c.PermissionFolderNotLocked = 1
		AND a.TeamID = @TeamId 
	GROUP BY 
		c.PermissionFolderNotLocked,
		c.PermissionFolderTypeId,
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
		s.SettingKey,
		d.MenuWidth
	ORDER BY 
		Sort, DeskSort
			
	SELECT * FROM #tmpDeskTop ORDER BY ExtraSort, Sort, DeskSort
	
	DROP TABLE #tmpDeskTop
	
END





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08054', GetDate())
GO