/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYearTrans_INSERT]    Script Date: 07/09/2012 18:21:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYearTrans_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYearTrans_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYearTrans_INSERT]    Script Date: 07/05/2012 17:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleSeasonYearTrans_INSERT]  (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@ChangeTransID UNIQUEIDENTIFIER,  
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName VARCHAR(200) = NULL
)
AS 


IF (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) = 0
BEGIN

	INSERT INTO pStyleSeasonYear(SeasonYearID, StyleID, StyleSeason, StyleYear, CUser, CDate, MUser, MDate)
	SELECT @SeasonYearID, @StyleID, Season, [Year], @CUser, @CDate, @CUser, @CDate 
	FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
	
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
VALUES ('DB_Version', '5.0.0000', '03743', GetDate())
GO