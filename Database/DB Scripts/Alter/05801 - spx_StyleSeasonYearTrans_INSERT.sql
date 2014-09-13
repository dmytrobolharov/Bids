/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYearTrans_INSERT]    Script Date: 06/04/2013 15:12:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYearTrans_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYearTrans_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSeasonYearTrans_INSERT]  (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@ChangeTransID UNIQUEIDENTIFIER,  
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName VARCHAR(200) = NULL,
	@Sort INT
)
AS 


IF (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) = 0
BEGIN

	INSERT INTO pStyleSeasonYear(SeasonYearID, StyleID, StyleSeason, StyleYear, CUser, CDate, MUser, MDate, Sort)
	SELECT @SeasonYearID, @StyleID, Season, [Year], @CUser, @CDate, @CUser, @CDate, @Sort
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
		DATEADD(DAY, CASE WHEN ISNUMERIC(wti.WorkflowDays) = 1 THEN -wti.WorkflowDays ELSE 0 END, sh.DueDate), wti.WorkflowAssignedTo, 6,
		NULL, NULL, wti.WorkflowSort, @CUser, @CDate, @CUser, @CDate, 
		CASE WHEN ISNUMERIC(wti.WorkflowDays) = 1 THEN wti.WorkflowDays ELSE 0 END, ssy.StyleSeasonYearID 
	FROM pStyleHeader sh 
	LEFT JOIN StyleSets ss ON sh.StyleSet >= ss.StyleSet
	INNER JOIN pWorkflowTemplateItem wti ON sh.WorkflowTemplateID = wti.WorkflowTemplateID
	INNER JOIN Mapping m ON wti.WorkflowID = m.Map
	INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
	WHERE sh.StyleID = @StyleID AND m.IsSeasonal = 1
		AND NOT EXISTS(SELECT * FROM pStyleWorkflow sw WHERE sw.StyleID = sh.StyleID AND sw.WorkflowID = wti.WorkflowID AND sw.StyleSeasonYearID = ssy.StyleSeasonYearID)
	
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



DROP TABLE #material




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05801', GetDate())
GO
