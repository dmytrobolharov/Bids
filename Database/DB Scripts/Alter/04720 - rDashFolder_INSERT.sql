IF NOT EXISTS (SELECT * FROM rDashFolder WHERE DashFolderName = 'Admin')
BEGIN
	DECLARE @FolderSort INTEGER = (SELECT TOP 1 CAST(DashFolderSort AS INTEGER) FROM rDashFolder ORDER BY DashFolderSort Desc)

	INSERT INTO rDashFolder (
		DashFolderID
		, DashFolderName
		, DashFolderSort
		, DashFolderActive) 
	VALUES (
		NEWID()
		, 'Admin'
		, RIGHT('00' + CAST(@FolderSort+1 AS NVARCHAR(5)), 3)
		, 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04720', GetDate())
GO
