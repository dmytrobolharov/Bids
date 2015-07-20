/****** Object:  StoredProcedure [dbo].[spx_DashFolder_Items_SELECT]    Script Date: 16.03.2015 15:14:35 ******/
IF OBJECT_ID(N'[dbo].[spx_DashFolder_Items_SELECT]') IS NOT NULL
DROP PROCEDURE [dbo].[spx_DashFolder_Items_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DashFolder_Items_SELECT]    Script Date: 16.03.2015 15:14:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DashFolder_Items_SELECT]
	@DashFolderID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive 
    FROM rDashFolderItem 
	WHERE DashFolderItemActive = 1 AND DashFolderItemVisible = 1 AND DashFolderID = @DashFolderID
    ORDER BY DashFolderItemSort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10008', GetUTCDate())
GO
