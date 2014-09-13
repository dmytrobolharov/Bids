IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleColorwayLogic_ApplyAll_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanStyleColorwayLogic_ApplyAll_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanStyleColorwayLogic_ApplyAll_UPDATE](
@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
@UpdateFields NVARCHAR(4000),
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 


DECLARE @output VARCHAR(8000)
DECLARE @Query NVARCHAR(4000)
SET @Query = 'UPDATE pStyleColorwaySeasonYear SET ' + @UpdateFields + 
' WHERE StyleColorwaySeasonYearID = ''' + CAST (@StyleColorwaySeasonYearID AS NVARCHAR(40)) + ''' '


EXEC spx_LinePlanStyleColorwayLogic_UPDATE
@StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID,
@Query = @Query,
@MUser = @MUser,
@MDate = @MDate,
@Result = @output OUTPUT,
@SelectOut = 0 


IF LEN(ISNULL(@output,'')) > 0 
BEGIN 
	SET @output = '<span style="color:red">' +  @output  + '<br/><br/></span>'
END 

SELECT @output AS Msg


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01612'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01612', GetDate())
END	

GO
