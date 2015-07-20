IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BIItem_AccessBIFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_SELECT] (   
	@GroupID uniqueidentifier
	, @BITypeID int  
)  
AS   
  
SELECT
	abi.*
	, (ISNULL(df.DashFolderName,'') + ISNULL(rf.ReportFolderName,'')) as FolderName
FROM
	sAccessBIItems abi
	LEFT OUTER JOIN rDashFolderItem dfi ON abi.ItemID = dfi.DashFolderItemID
	LEFT OUTER JOIN rDashFolder df ON dfi.DashFolderID = df.DashFolderID
	LEFT OUTER JOIN rReportFolderItem rfi ON abi.ItemID = rfi.reportFolderItemID
	LEFT OUTER JOIN rReportFolder rf ON rfi.ReportFolderID = rf.ReportFolderID
WHERE
	abi.GroupID = @GroupID
	AND abi.BITypeID = @BITypeID 
	AND (ItemID IN (select ReportFolderItemID from rReportFolderItem) OR ItemID IN (select DashFolderItemID from rDashFolderItem))
	AND (rfi.ReportFolderID IN (select ReportFolderID from rReportFolder) OR dfi.DashFolderID IN (select DashFolderID from rDashFolder))
ORDER BY
	df.DashFolderSort
	, rf.ReportFolderSort
	, dfi.DashFolderItemSort
	, rfi.ReportItemSort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05058', GetDate())
GO
