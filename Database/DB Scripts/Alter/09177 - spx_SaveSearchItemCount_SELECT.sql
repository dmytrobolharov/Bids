/****** Object:  StoredProcedure [dbo].[spx_SaveSearchItemCount_SELECT]    Script Date: 12/01/2014 12:45:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SaveSearchItemCount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SaveSearchItemCount_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SaveSearchItemCount_SELECT]    Script Date: 12/01/2014 12:45:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SaveSearchItemCount_SELECT]
	@SearchName nvarchar (200),
	@TeamID uniqueidentifier,
	@SavedSearchID uniqueidentifier = NULL,
	@FolderName nvarchar (100) = NULL
AS
BEGIN
	SET NOCOUNT ON;	
	IF @FolderName IS NULL
    BEGIN
		SELECT @FolderName = Folder FROM pSavedSearch WHERE SavedSearchID = @SavedSearchID
		SELECT COUNT(*) 
		FROM pSavedSearch 
		WHERE TeamID = @TeamID AND SearchName = @SearchName AND Folder = @FolderName AND SavedSearchID != @SavedSearchID
    END
    ELSE
    BEGIN
		SELECT COUNT(*) 
		FROM pSavedSearch 
		WHERE TeamID = @TeamID AND SearchName = @SearchName AND Folder = @FolderName
    END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09177', GetDate())
GO