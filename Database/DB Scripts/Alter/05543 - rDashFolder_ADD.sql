IF NOT EXISTS (SELECT * FROM rDashFolder WHERE DashFolderName = 'Trade Partners')
BEGIN
	DECLARE @FolderSort INTEGER = (SELECT TOP 1 CAST(DashFolderSort AS INTEGER) FROM rDashFolder ORDER BY DashFolderSort Desc)

	INSERT INTO rDashFolder (
		DashFolderID
		, DashFolderName
		, DashFolderSort
		, DashFolderActive) 
	VALUES (
		NEWID()
		, 'Trade Partners'
		, RIGHT('00' + CAST(@FolderSort+1 AS NVARCHAR(5)), 3)
		, 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05543', GetDate())
GO
