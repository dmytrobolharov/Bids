IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Style_SeasonalMaterialColorwayBOMReportName_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Style_SeasonalMaterialColorwayBOMReportName_SELECT]
GO

CREATE PROCEDURE [dbo].[Style_SeasonalMaterialColorwayBOMReportName_SELECT]
(
	@WorkflowItemID UNIQUEIDENTIFIER
	, @ReportPageID UNIQUEIDENTIFIER
)
AS
BEGIN

DECLARE @WorkflowItemName NVARCHAR(500)
DECLARE @ReportPageName NVARCHAR(500)

SELECT @ReportPageName = ReportPageDescription FROM rReportStylePageItem WHERE ReportPageID = @ReportPageID
SELECT @WorkflowItemName = WorkFlowItemName FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkFlowItemID

SELECT @ReportPageName + ' (' + @WorkflowItemName + ')' AS ReportPageDescription

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05618', GetDate())
GO
