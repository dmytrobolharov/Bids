/****** Object:  StoredProcedure [dbo].[spx_DeskTopItems_RESET]    Script Date: 04/23/2012 12:44:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTopItems_RESET]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTopItems_RESET]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTopItems_RESET]    Script Date: 04/23/2012 12:44:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskTopItems_RESET]
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- remove all desktop setting for given user
	DELETE FROM uUserSetting WHERE TeamID = @TeamID AND (SettingSection = 'DeskTopItems' OR SettingSection = 'DeskMenuItems')
	
	-- recreate desktop item by pattern
	EXEC spx_DeskTopItems_SELECT @TeamID
END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03388', GetDate())

GO