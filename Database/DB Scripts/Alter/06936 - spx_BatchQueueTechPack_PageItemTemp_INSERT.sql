IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueTechPack_PageItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQueueTechPack_PageItemTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQueueTechPack_PageItemTemp_INSERT]
	@ReportBatchQueueID UNIQUEIDENTIFIER,
	@ReportTechpackID UNIQUEIDENTIFIER,
	@ReportPageID UNIQUEIDENTIFIER,
	@WorkflowItemID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@StyleHeaderID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@TechPackName NVARCHAR(200),
	@TechPackFinal INT,
	@Sort INT,
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
	@IsTechPackOnTheFly INT = NULL,
	@BatchQueueJobID UNIQUEIDENTIFIER = NULL
AS
IF @WorkflowID = @WorkflowItemID 
BEGIN
	SET @WorkflowItemID = '00000000-0000-0000-0000-000000000000'
END

IF NOT EXISTS (
	SELECT * FROM rReportStylePageItemTemp WITH(NOLOCK) WHERE ReportBatchQueueID = @ReportBatchQueueID AND StyleID = @StyleID  
	AND SeasonYearID = @SeasonYearID AND ReportPageID = @ReportPageID AND WorkflowID = @WorkflowID AND WorkflowItemID = @WorkflowItemID)
BEGIN	 
	DECLARE @ReportStylePageItemTemp TABLE (
		ReportBatchQueueID UNIQUEIDENTIFIER,
		ReportStylePageItemID UNIQUEIDENTIFIER,
		ReportPageID UNIQUEIDENTIFIER,
		ReportTechpackID UNIQUEIDENTIFIER,
		ReportMapID UNIQUEIDENTIFIER,
		ReportPageTypeID UNIQUEIDENTIFIER,
		ReportTemplateName NVARCHAR(200),
		ReportPageName NVARCHAR(200),
		ReportPageDescription NVARCHAR(4000),
		ReportServerType nVARCHAR(5),
		ReportFormName nVARCHAR(250),
		ReportPageURL nVARCHAR(250),
		ReportPKIField nVARCHAR(200),
		ReportPageActive INT,
		ReportPageFormat nVARCHAR(7),
		ReportSrmOn INT,
		SeasonYearID UNIQUEIDENTIFIER,
		StyleHeaderID UNIQUEIDENTIFIER,
		StyleID UNIQUEIDENTIFIER,
		StyleDevelopmentID UNIQUEIDENTIFIER,
		StyleSet INT,
		Sort INT,
		TechPackName NVARCHAR(200),
		TechPackFinal INT,
		StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
		WorkflowItemID UNIQUEIDENTIFIER,
		WorkflowID UNIQUEIDENTIFIER
	)
	
	DECLARE @NumberOfImages INT
	SET  @NumberOfImages = ISNULL(@NumberOfImages,2) --FROM pBatchQTechPackImagePerPage WITH(NOLOCK) WHERE BatchQueueJobID = @BatchQueueJobID
	
	IF @IsTechPackOnTheFly = 1
		BEGIN
			--INSERT INTO rReportStylePageItemTemp(ReportBatchQueueID, ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,
			--ReportTemplateName, ReportPageName , ReportPageDescription,
			--ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,
			--StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID)
			INSERT INTO @ReportStylePageItemTemp
			SELECT
				@ReportBatchQueueID, NEWID() AS ReportStylePageItemID, ReportPageID, @ReportTechpackID, ReportMapID, ReportPageTypeID,
				ReportTemplateName,
				CASE 
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006' AND @NumberOfImages = 2 THEN 'Design Detail 2 Per Page'
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006' AND @NumberOfImages = 1 THEN 'Design Detail 1 Per Page'
					ELSE ReportPageName
				END AS ReportPageName,
				CASE
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006' AND @NumberOfImages = 2 THEN 'Design Detail 2 Per Page'
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006' AND @NumberOfImages = 1 THEN 'Design Detail 1 Per Page'
					ELSE ReportPageDescription
				END AS ReportPageDescription,
				ReportServerType,
				ReportFormName,
				ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, @SeasonYearID, @StyleHeaderID,
				@StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
				@WorkflowItemID, @WorkflowID
			FROM rReportStylePageItem WHERE ReportPageID = @ReportPageID
		END
	ELSE
		BEGIN
			--INSERT INTO rReportStylePageItemTemp(ReportBatchQueueID, ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,
			-- ReportTemplateName, ReportPageName , ReportPageDescription,
			-- ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,
			-- StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID)
			INSERT INTO @ReportStylePageItemTemp
			SELECT
				@ReportBatchQueueID, NEWID() AS ReportStylePageItemID, ReportTechPackPageID, @ReportTechpackID, ReportMapID, ReportPageTypeID,
				ReportTemplateName,
				CASE
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006' AND @NumberOfImages = 2 THEN 'Design Detail 2 Per Page'
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006' AND @NumberOfImages = 1 THEN 'Design Detail 1 Per Page'
					ELSE ReportPageName
				END AS ReportPageName,
				CASE
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006'  AND @NumberOfImages = 2 THEN 'Design Detail 2 Per Page'
					WHEN ReportMapID = '40000000-0000-0000-0000-000000000006'  AND @NumberOfImages = 1 THEN 'Design Detail 2 Per Page'
					ELSE ReportPageDescription
				END AS ReportPageDescription,
				ReportServerType,
				--CASE
				--	WHEN ReportMapID = '40000000-0000-0000-0000-000000000006'  AND @NumberOfImages = 2 THEN 'AEROPOSTALE_Style_DesignDetail_2_(Header_B)_Body_LLT'
				--	WHEN ReportMapID = '40000000-0000-0000-0000-000000000006'  AND @NumberOfImages = 1 THEN 'AEROPOSTALE_Style_DesignDetail_(Header_B)_Body_LLT'
				--	ELSE ReportFormName
				--END AS 
				ReportFormName,
				ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, 0, @SeasonYearID, @StyleHeaderID,
				@StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
				@WorkflowItemID, @WorkflowID
			FROM rReportTechPackPageItem WHERE ReportTechPackPageID = @ReportPageID
		END
	END

	DECLARE @ReportMapID UNIQUEIDENTIFIER
	DECLARE @ReportPageName NVARCHAR(200)
	DECLARE @ReportFormName nVARCHAR(250)
	DECLARE @IStyleID UNIQUEIDENTIFIER
	DECLARE @IStyleSet INT
	DECLARE @ReportPageActive INT

	DECLARE CursorReportStylePageItemTemp CURSOR FOR
	SELECT ReportMapID, ReportPageName, ReportFormName, StyleID, StyleSet FROM @ReportStylePageItemTemp

	OPEN CursorReportStylePageItemTemp
	FETCH NEXT FROM CursorReportStylePageItemTemp INTO @ReportMapID, @ReportPageName, @ReportFormName, @IStyleID, @IStyleSet

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @ResultTable AS TABLE (Active INT)
		INSERT INTO @ResultTable EXECUTE dbo.spx_CheckTechPackPageItemActive @ReportMapID = @ReportMapID, @ReportPageName = @ReportPageName, @ReportFormName = @ReportFormName, @StyleID = @IStyleID, @StyleSet = @IStyleSet

		UPDATE @ReportStylePageItemTemp
		SET ReportPageActive = (SELECT Active FROM @ResultTable)
		WHERE ReportMapID = @ReportMapID AND ReportPageName = @ReportPageName AND ReportFormName = @ReportFormName AND StyleID = @IStyleID AND StyleSet = @IStyleSet

		FETCH NEXT FROM CursorReportStylePageItemTemp INTO @ReportMapID, @ReportPageName, @ReportFormName, @IStyleID, @IStyleSet
	END

	CLOSE CursorReportStylePageItemTemp
	DEALLOCATE CursorReportStylePageItemTemp

	INSERT INTO rReportStylePageItemTemp (
		ReportBatchQueueID, ReportStylePageItemID, ReportPageID, ReportTechPackID, ReportMapID, ReportPageTypeID,   
		ReportTemplateName, ReportPageName, ReportPageDescription,   
		ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID,
		StyleID, StyleDevelopmentID, StyleSet, Sort, TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID
	)
	SELECT
		ReportBatchQueueID, ReportStylePageItemID, ReportPageID, ReportTechPackID, ReportMapID, ReportPageTypeID,   
		ReportTemplateName, ReportPageName, ReportPageDescription,   
		ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID,
		StyleID, StyleDevelopmentID, StyleSet, Sort, TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID
	FROM @ReportStylePageItemTemp WHERE ReportPageActive = 1
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06936', GetDate())
GO
