/****** Object:  StoredProcedure [dbo].[spx_ReportFolder_Items_SELECT]    Script Date: 16.03.2015 15:20:34 ******/
IF OBJECT_ID(N'[dbo].[spx_ReportFolder_Items_SELECT]') IS NOT NULL
DROP PROCEDURE [dbo].[spx_ReportFolder_Items_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ReportFolder_Items_SELECT]    Script Date: 16.03.2015 15:20:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ReportFolder_Items_SELECT]
	@ReportFolderID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM rReportFolderItem 
	WHERE ReportFolderID = @ReportFolderID 
	AND ReportFolderItemActive = 1 AND ReportFolderItemVisible = 1
	ORDER BY ReportItemSort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10009', GetUTCDate())
GO
