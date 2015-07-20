IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackTemp_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_TechPackTemp_DELETE]
(@BatchQueueID uniqueidentifier = null,
 @ReportTechPackID uniqueidentifier,
 @TechPackType nvarchar (10))
AS 

IF @TechPackType = 'PSTP'
BEGIN
	DELETE FROM rReportStyleTemp WHERE (DataXmlId = @ReportTechPackID)
	DELETE FROM rReportTable WHERE (DataXmlId = @ReportTechPackID)
END

ELSE IF @TechPackType = 'OTFSTP'
BEGIN
	DELETE FROM rReportStylePageItemTemp WHERE (ReportTechPackID = @ReportTechPackID)
	DELETE FROM rReportTable WHERE (DataXmlId = @ReportTechPackID)
END

IF NOT @BatchQueueID IS NULL
BEGIN
	EXECUTE spx_BatchQueue_DELETE @BatchQueueID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '657', GetDate())

GO





