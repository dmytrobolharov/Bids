/****** Object:  StoredProcedure [dbo].[spx_TechPackTemp_DELETE]    Script Date: 06/10/2010 14:00:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackTemp_DELETE]
(@BatchQueueID uniqueidentifier,
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

EXECUTE spx_BatchQueue_DELETE @BatchQueueID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '153', GetDate())
GO
