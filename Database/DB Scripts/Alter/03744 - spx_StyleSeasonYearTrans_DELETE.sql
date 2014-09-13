/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYearTrans_DELETE]    Script Date: 07/09/2012 18:18:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYearTrans_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYearTrans_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYearTrans_DELETE]    Script Date: 07/05/2012 17:12:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleSeasonYearTrans_DELETE]  (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@ChangeTransID UNIQUEIDENTIFIER,  
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName VARCHAR(200) = NULL
)
AS 

IF(SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) > 0
BEGIN

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
     
END


IF (SELECT COUNT(*) FROM pStyleColorwaySeasonYear INNER JOIN
    pStyleSeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
	WHERE pStyleSeasonYear.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID) = 0

BEGIN

	DELETE FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID 
	


END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03744', GetDate())
GO