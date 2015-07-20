IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYearTrans_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYearTrans_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleSeasonYearTrans_INSERT] (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200), 
	@CDate DATETIME,
	@ChangeTransID UNIQUEIDENTIFIER,  
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200) = NULL,
	@Sort INT
)
AS 


IF (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) = 0
BEGIN
	
	declare @StyleSeasonYearID UNIQUEIDENTIFIER = NEWID()

	INSERT INTO pStyleSeasonYear(StyleSeasonYearID, SeasonYearID, StyleID, StyleSeason, StyleYear, CUser, CDate, MUser, MDate, Sort)
	SELECT @StyleSeasonYearID, @SeasonYearID, @StyleID, Season, [Year], @CUser, @CDate, @CUser, @CDate, @Sort
	FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
	
DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @Season NVARCHAR(200)  
DECLARE @Year NVARCHAR(200) 
 
 SELECT @Season=a.Season, @Year=a.Year 
 FROM pSeasonYear a
 WHERE a.SeasonYearID = @SeasonYearID
 
 DECLARE @Changeseason NVARCHAR(400)  
 SET @Changeseason = ''+ ISNULL(@Season,'') + ' ' + ISNULL(@Year,'')
 
	-- insert seasonal workflows along with season year
	;WITH StyleSets(StyleSet) as (
		-- is used to get all combination with style sets up to a number of style sets in style
		SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
	)
	INSERT INTO pStyleWorkflow(
		StyleID, StyleSet, WorkflowID, WorkflowType, WorkDate, WorkStart, 
		WorkDue, WorkAssignedTo,  WorkStatus, 
		WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, 
		WorkDay, StyleSeasonYearID)	
	SELECT sh.StyleID, ss.StyleSet, wti.WorkflowID, NULL, GETDATE(), GETDATE(), 
		DATEADD(DAY, CASE WHEN ISNUMERIC(wti.WorkflowDays) = 1 THEN -wti.WorkflowDays ELSE 0 END, sh.DueDate), wti.WorkflowAssignedTo, 1,
		NULL, NULL, wti.WorkflowSort, @CUser, @CDate, @CUser, @CDate, 
		CASE WHEN ISNUMERIC(wti.WorkflowDays) = 1 THEN wti.WorkflowDays ELSE 0 END, ssy.StyleSeasonYearID 
	FROM pStyleHeader sh 
	LEFT JOIN StyleSets ss ON sh.StyleSet >= ss.StyleSet
	INNER JOIN pWorkflowTemplateItem wti ON sh.StyleWorkflowID = wti.WorkflowTemplateID
	INNER JOIN Mapping m ON wti.WorkflowID = m.Map
	INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
	WHERE sh.StyleID = @StyleID AND m.IsSeasonal = 1
		AND NOT EXISTS(SELECT * FROM pStyleWorkflow sw WHERE sw.StyleID = sh.StyleID AND sw.WorkflowID = wti.WorkflowID AND sw.StyleSeasonYearID = ssy.StyleSeasonYearID)
		
	-- make copy of DBOM Workflow Items for newly added season year
	if EXISTS(SELECT * FROM pStyleWorkflow WHERE StyleID = @StyleID AND WorkflowID = '40000000-0000-0000-0000-000000000080')
	begin
		declare @copyStyleSeasonYearID UNIQUEIDENTIFIER
		SELECT TOP 1 @copyStyleSeasonYearID = ssy.StyleSeasonYearID FROM pStyleSeasonYear ssy 
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID 
		WHERE StyleID = @StyleID AND (SeasonOrder < (SELECT SeasonOrder FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID))
		ORDER BY SeasonOrder DESC
		
		if @copyStyleSeasonYearID IS NULL
			SELECT TOP 1 @copyStyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear 
			WHERE StyleID = @StyleID AND StyleSeasonYearID <> @StyleSeasonYearID
			ORDER BY CDate DESC
			
		declare @DBOMWorkflowItems TABLE(
			ROW INT IDENTITY(1, 1),
			WorkflowItemID UNIQUEIDENTIFIER,
			MasterID UNIQUEIDENTIFIER,
			StyleSet INT)
		INSERT INTO @DBOMWorkflowItems(WorkflowItemID, MasterID, StyleSet)
		SELECT WorkflowItemID, WorkflowItemMasterID, StyleSet FROM pWorkFlowItem 
		WHERE StyleID = @StyleID
			AND WorkflowID = '40000000-0000-0000-0000-000000000080'
			AND StyleSeasonYearID = @copyStyleSeasonYearID
			
		declare @WFROW INT = 1,
				@WFTOTAL INT = (SELECT COUNT(*) FROM @DBOMWorkflowItems)
		while @WFROW <= @WFTOTAL
		begin
			declare @WorkflowItemID UNIQUEIDENTIFIER,
					@MasterID UNIQUEIDENTIFIER,
					@StyleSet INT;
					
			SELECT @WorkflowItemID = WorkflowItemID, @MasterID = MasterID, @StyleSet = StyleSet 
			FROM @DBOMWorkflowItems WHERE ROW = @WFROW
		
			exec spx_WorkflowItem_COPY 
				@WorkflowID = '40000000-0000-0000-0000-000000000080',  
				@WorkFlowItemId = @WorkflowItemID,  
				@StyleID = @StyleID,  
				@CopyStyleID = @StyleID,  
				@StyleSet = @StyleSet,  
				@CopyStyleSet = @StyleSet,  
				@CUser = @CUser,
				@CDate = @CDate,
				@StyleSeasonYearID = @StyleSeasonYearID	
				
			UPDATE pWorkFlowItem SET 
				StyleSeasonYearID = @StyleSeasonYearID,
				WorkflowItemMasterID = @MasterID,
				WorkStart = sw.WorkStart,
				WorkDue = sw.WorkDue,
				--WorkAssignedTo = sw.WorkAssignedTo,
				WorkStatus = sw.WorkStatus--,
				--WorkEscalateTo = sw.WorkEscalateTo
			FROM pStyleWorkflow sw
			WHERE sw.WorkflowID = '40000000-0000-0000-0000-000000000080'
				AND sw.StyleSeasonYearID = @StyleSeasonYearID
				AND sw.StyleID = @StyleID AND sw.StyleSet = @StyleSet 
				AND pWorkFlowItem.StyleID = @StyleID AND pWorkFlowItem.StyleSet = @StyleSet 
				AND pWorkFlowItem.WorkflowID = '40000000-0000-0000-0000-000000000080'
				AND pWorkFlowItem.StyleSeasonYearID IS NULL
				
			set @WFROW = @WFROW + 1
		end
	end
	
	
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
  @ChangeTransTypeID = 1
   
 EXECUTE spx_ChangeLogItem_INSERT  
  @ChangeLogID = @ChangeLogID,  
  @ChangeTransID = @ChangeTransID,  
  @ChangeFieldName = 'StyleColorwaySeasonYearID',  
  @ChangeFieldAlias = 'Add season',  
  @ChangeBeforeValue = NULL,  
  @ChangeAfterValue = @SeasonYearID,  
  @ChangeBeforeText = NULL,  
  @ChangeAfterText = @Changeseason,  
  @ChangeSort = '0001'   
  

END
ELSE
BEGIN

	UPDATE pStyleSeasonYear SET Sort = @Sort WHERE SeasonYearID = @SeasonYearID
	
END

-- Add SeasonYear to Materials 

CREATE TABLE  #material(
ROW_ID INT IDENTITY (1,1),
MaterialID UNIQUEIDENTIFIER 
)	

INSERT INTO #material ( MaterialID) 
SELECT DISTINCT MaterialID FROM pStyleMaterials WHERE StyleID = @StyleID

DECLARE @TOTAL INT
DECLARE @ROW_ID INT 

SELECT @TOTAL = COUNT(*) FROM #material 
SET @ROW_ID = 1

DECLARE @MaterialID UNIQUEIDENTIFIER 

WHILE @ROW_ID <= @TOTAL 
BEGIN
	SELECT @MaterialID = MaterialID FROM #material WHERE ROW_ID = @ROW_ID

	IF ( SELECT COUNT(*) FROM pMaterialSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID  = @SeasonYearID ) = 0
	BEGIN
		SELECT * FROM pMaterialSeasonYear
		INSERT INTO pMaterialSeasonYear ( MaterialSeasonYearID , SeasonYearID , MaterialID , CUser, CDate ) 
		VALUES ( NEWID() , @SeasonYearID , @MaterialID , @CUser, @CDate  ) 
	END 

	SET @ROW_ID = @ROW_ID + 1 

END 

-- add tech pack status record for newly added season year
INSERT INTO pStyleTechPackStatus(
	StyleID, StyleSeasonYearID, WorkStatus,
	CUser, CDate, MUser, MDate)
SELECT ssy.StyleID, ssy.StyleSeasonYearID, 1,
	'SYSTEM', GETDATE(), 'SYSTEM', GETDATE()
FROM pStyleSeasonYear ssy
LEFT JOIN pStyleTechPackStatus stps ON ssy.StyleSeasonYearID = stps.StyleSeasonYearID
WHERE ssy.StyleSeasonYearID = @StyleSeasonYearID 
	AND stps.StyleTechPackStatusID IS NULL


DROP TABLE #material



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09969', GetUTCDate())
GO
