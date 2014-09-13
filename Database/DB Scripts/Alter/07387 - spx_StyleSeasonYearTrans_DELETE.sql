IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYearTrans_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYearTrans_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleSeasonYearTrans_DELETE]  (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@ChangeTransID UNIQUEIDENTIFIER,  
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName nVARCHAR(200) = NULL
)
AS 

IF(SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) > 0
BEGIN


IF ((SELECT COUNT(*) FROM pStyleColorwaySeasonYear INNER JOIN
    pStyleSeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID)
	+
	(SELECT COUNT(*) FROM pSampleRequestBOMTrade INNER JOIN 
	pStyleSeasonYear ON pSampleRequestBOMTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID)
	+
	(SELECT COUNT(*) FROM pSampleRequestTrade INNER JOIN 
	pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID)
	+
	(SELECT COUNT(*) FROM pStyleQuoteItem INNER JOIN 
	pStyleSeasonYear ON pStyleQuoteItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID)
	+
	(SELECT COUNT(*) FROM pLineFolderItem INNER JOIN 
	pStyleSeasonYear ON pLineFolderItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID)
	+
	(SELECT COUNT(*) FROM pPlanningItem INNER JOIN 
	pStyleSeasonYear ON pPlanningItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID)) = 0

BEGIN

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID)
	DELETE FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID
	
	-- delete seasonal workflows for this season
	DELETE FROM pStyleWorkflow WHERE StyleSeasonYearID = @StyleSeasonYearID
	
	-- delete workflow items for seasonal multi-workflows
	DECLARE @WorkflowItems TABLE(
		ROW INT IDENTITY(1, 1),
		WorkflowItemID UNIQUEIDENTIFIER
	)
	INSERT INTO @WorkflowItems(WorkflowItemID)
	SELECT WorkflowItemID FROM pWorkFlowItem wfi
	INNER JOIN Mapping m ON wfi.WorkflowID = m.Map
	WHERE StyleSeasonYearID = @StyleSeasonYearID AND m.IsSeasonal = 1
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @WorkflowItems)
			
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @WorkflowID UNIQUEIDENTIFIER,
				@WorkflowItemID UNIQUEIDENTIFIER,
				@StyleSet INT;
		
		SELECT @WorkflowItemID = wfi.WorkFlowItemID, @WorkflowID = wfi.WorkflowID, @StyleSet = wfi.StyleSet 
		FROM @WorkflowItems twfi 
		LEFT JOIN pWorkFlowItem wfi ON twfi.WorkflowItemID = wfi.WorkFlowItemID
		WHERE twfi.ROW = @ROW		
		
		exec spx_WorkflowItem_DELETE @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet
		
		SET @ROW = @ROW + 1
	END
	
	
	/***** change log *****/
	DECLARE @ChangeLogID UNIQUEIDENTIFIER
	DECLARE @Season NVARCHAR(200)  
	DECLARE @Year NVARCHAR(200) 
	 
	 SELECT @Season=a.Season, @Year=a.Year 
	 FROM pSeasonYear a
	 WHERE a.SeasonYearID = @SeasonYearID
	 
	 DECLARE @Changeseason NVARCHAR(400)  
	 SET @Changeseason = ''+ ISNULL(@Season,'') + ' ' + ISNULL(@Year,'')
		
	 EXECUTE spx_ChangeLog_INSERTID  
	  @changeTableId = '00000002-c1cc-df11-af06-005056c00008',  
	  @changeTransId = @ChangeTransID,  
	  @changeTablePKId = @StyleID,  
	  @changeUserId = @ChangeTransUserID,   
	  @ChangeUserName = @CUser,  
	  @changeDate = @CDate,  
	  @changeSort = '0000',  
	  @ShowResult = 0,  
	  @ChangeLogID = @ChangeLogID OUTPUT,
	  @ChangeTransPageName = @ChangeTransPageName,
	  @ChangeTransTypeID = 2
	   
	 EXECUTE spx_ChangeLogItem_INSERT  
	  @ChangeLogID = @ChangeLogID,  
	  @ChangeTransID = @ChangeTransID,  
	  @ChangeFieldName = 'StyleColorwaySeasonYearID',  
	  @ChangeFieldAlias = 'Remove season',  
	  @ChangeBeforeValue = @SeasonYearID,  
	  @ChangeAfterValue = NULL,  
	  @ChangeBeforeText = @Changeseason,  
	  @ChangeAfterText = NULL,  
	  @ChangeSort = '0001'
	/***** end change log *****/

END


END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07387', GetDate())
GO
