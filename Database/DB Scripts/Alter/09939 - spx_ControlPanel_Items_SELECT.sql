-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 5 March 2015                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2015 Gerber Technology, Inc.  All rights reserved.                      */
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

IF OBJECT_ID(N'[dbo].[spx_ControlPanel_Items_SELECT]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_ControlPanel_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ControlPanel_Items_SELECT]
( 
	@TeamID AS NVARCHAR(50),
	@Filter As nvarchar(MAX) = null
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
	WHERE access.PermissionRoleId <> 0
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
		WHERE ControlPanelName LIKE '%' + @Filter + '%'
		ORDER BY Sort, ControlPanelOrder 	
	DROP TABLE #TempCMPControlPanel
	DROP TABLE #TempControlPanel
END
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09939', GetUTCDate())
GO
