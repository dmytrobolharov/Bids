/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_TechPackCreateZip_StyleFiles_SELECT]    Script Date: 26.02.2015 14:39:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_TechPackCreateZip_StyleFiles_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_TechPackCreateZip_StyleFiles_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_TechPackCreateZip_StyleFiles_SELECT]    Script Date: 26.02.2015 14:39:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_TechPackCreateZip_StyleFiles_SELECT](
	@BatchQueueJobID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER
)
AS 
BEGIN

DECLARE 
	@ReportTechPackFolderID UNIQUEIDENTIFIER,
	@ReportTechPackFolderName NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER

	
SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WITH(NOLOCK) WHERE BatchQueueJobID = @BatchQueueJobID

--** Get the Techpack type selected 
SELECT @ReportTechPackFolderID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0002'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId
	
SELECT @ReportTechPackFolderName = ReportTechPackFolderName 
FROM dbo.rReportTechPackFolder WITH(NOLOCK)  WHERE ReportTechPackFolderID = @ReportTechPackFolderID

DECLARE 
	@TechPackID UNIQUEIDENTIFIER

--** Techpack shared
SELECT TOP 1 @TechPackID = a.TechPackID 
FROM dbo.pTechPack a WITH(NOLOCK)
	INNER JOIN  dbo.pTechPackTeam b WITH (NOLOCK) ON b.TechPackID = a.TechPackID  
WHERE a.StyleID = @StyleID  
	AND a.TechPackName = @ReportTechPackFolderName
	AND b.TeamID = @TeamID
ORDER BY TechPackNo DESC

DECLARE 
	@STYLEDOCUMENTPATH NVARCHAR(200),
	@PDFPATH NVARCHAR(200)
	
SELECT @STYLEDOCUMENTPATH = AppSettingValue FROM dbo.sAppSetting WITH(NOLOCK)WHERE ConfigFileName = 'Storage.config' AND AppSettingKey = 'STYLEDOCUMENTPATH'
SELECT @PDFPATH = AppSettingValue FROM dbo.sAppSetting WITH(NOLOCK)WHERE ConfigFileName = 'Storage.config' AND AppSettingKey = 'PDFPATH'



DECLARE 
	@TechPackFileName NVARCHAR(500)

IF @TechPackID IS NOT NULL 
BEGIN 
	
	SELECT @TechPackFileName = 'Techpack_' +  
		CASE 
			WHEN LEN(ISNULL(CustomField30,'')) > 0  THEN CustomField30 
			WHEN LEN(ISNULL(StyleNo,'')) > 0  THEN StyleNo
			ELSE 'Style'
		END 
		+ '.pdf'
	FROM dbo.pStyleHeader WITH(NOLOCK)
	WHERE StyleID = @StyleID 

END 


--** TechPack
SELECT 
	@PDFPATH + '\' + 
	'{' + CAST(@StyleID AS NVARCHAR(40)) + '}\' + 
	'{' + CAST(@TechPackID AS NVARCHAR(40)) + '}.pdf' 
	AS FILEPATH, 1 AS FileType, @TechPackFileName AS [FileName]
UNION
--** Attachments
--** Comment #01
SELECT 
	@STYLEDOCUMENTPATH + '\{' + 
	CAST(@StyleID AS NVARCHAR(40)) + '}\Document\{' + 
	CAST(StyleDocumentID AS NVARCHAR(40) ) + '}\' +  
	StyleDocumentName AS FILEPATH, 2 AS FileType,  StyleDocumentName AS [FileName]
FROM pStyleDocument 
WHERE StyleId = @StyleId AND StyleDocumentShared = 1


END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09754', GetDate())
GO
