/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_Items_SELECT]    Script Date: 06/05/2014 13:29:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlPanel_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlPanel_Items_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_Items_SELECT]    Script Date: 06/05/2014 13:29:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_ControlPanel_Items_SELECT] ( 
@TeamID AS NVARCHAR(50)
)
AS 

BEGIN

	CREATE TABLE #TempCMPControlPanel 
	(
		Id int IDENTITY (1, 1) NOT NULL, 
		ControlPanelName NVARCHAR(100)	
	) 

	CREATE TABLE [dbo].#TempControlPanel
	(
		[ControlPanelID] [int] NOT NULL,
		[ControlPanelName] [nvarchar](50) NULL,
		[ControlPanelDescription] [nvarchar](200) NULL,
		[ControlPanelOrder] [int] NULL,
		[ControlPanelIdSchema] [nvarchar](200) NULL,
		[ControlPanelSchema] [nvarchar](200) NULL,
		[ControlPanelSearchSchema] [nvarchar](200) NULL,
		[ControlPanelTableName] [nvarchar](100) NULL,
		[ControlPanelUrl] [nvarchar](100) NULL,
		[ControlPanelEditSchema] [nvarchar](200) NULL,
		[SPXLogicInsert] [nvarchar](200) NULL,
		[SPXLogicUpdate] [nvarchar](200) NULL,
		[ControlPanelTypeID] [uniqueidentifier] NULL,
		[ControlPanelRepId] [uniqueidentifier] NOT NULL,
		[IsDataValidation] [int] NULL,
		[Sort] [int] NULL
	)		
	
	INSERT INTO 
		#TempCMPControlPanel(ControlPanelName) 
		SELECT 
			DISTINCT ControlPanelName 
		FROM pControlPanel cp
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 10) access
		ON cp.ControlPanelID = access.ProductTypeID
	WHERE 
		IsDataValidation = 0 
		AND access.PermissionRoleId <> 0

	DECLARE @I as int
	DECLARE @Row_Count int
	DECLARE @ControlPanelName NVARCHAR(100)
	DECLARE @ControlPanelTypeID UNIQUEIDENTIFIER

	SET @Row_Count = (SELECT COUNT(*) FROM #TempCMPControlPanel)
		
	SET @I = 1

	WHILE @I <= @Row_Count 
	BEGIN

		SELECT 
			@ControlPanelName=ControlPanelName 
		FROM #TempCMPControlPanel 
			WHERE ID = @I
		INSERT INTO #TempControlPanel	
		SELECT 
			TOP 1 * 
		FROM 
			pControlPanel WHERE ControlPanelName= @ControlPanelName 
		SET @I = @I + 1		
	END	
		
	SELECT * 
	FROM 
		#TempControlPanel 
	ORDER BY Sort, ControlPanelOrder 	
	                
	DROP TABLE #TempCMPControlPanel
	DROP TABLE #TempControlPanel

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07904', GetDate())
GO
