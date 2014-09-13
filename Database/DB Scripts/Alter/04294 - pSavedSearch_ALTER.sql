IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSavedSearch' and COLUMN_NAME = N'StyleTypeID')
BEGIN 

	CREATE TABLE #SavedSearches (SavedSearchID UNIQUEIDENTIFIER, TypeID INT)
	
	INSERT INTO #SavedSearches (SavedSearchID, TypeID)
	SELECT SavedSearchID, StyleTypeID from pSavedSearch

	exec sp_rename 'pSavedSearch.StyleTypeID', 'TypeID', 'COLUMN'
	
	UPDATE pSavedSearch SET TypeID = #SavedSearches.TypeID FROM #SavedSearches WHERE pSavedSearch.SavedSearchID = #SavedSearches.SavedSearchID
	
	DROP TABLE #SavedSearches

END
GO


IF NOT EXISTS(select * from sys.columns where Name = N'Folder' and Object_ID = Object_ID(N'pSavedSearch'))
BEGIN      
-- Column Exists 
	ALTER TABLE pSavedSearch ADD Folder nvarchar(100) null
END
GO

IF EXISTS (SELECT * FROM pSavedSearch WHERE Folder IS NULL)
BEGIN
	UPDATE pSavedSearch SET Folder = 'Style' WHERE Folder IS NULL
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04294', GetDate())
GO
