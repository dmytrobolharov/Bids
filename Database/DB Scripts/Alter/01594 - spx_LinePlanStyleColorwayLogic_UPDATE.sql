IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleColorwayLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanStyleColorwayLogic_UPDATE]
GO

CREATE PROCEDURE  [dbo].[spx_LinePlanStyleColorwayLogic_UPDATE] (
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER , 
	@Query NVARCHAR(4000) ,
	@MUser NVARCHAR(200), 
	@MDate DATETIME,
	@Result VARCHAR(8000) = NULL OUTPUT,
	@SelectOut INT = 1
)
AS 


DECLARE @StyleColorId UNIQUEIDENTIFIER
DECLARE @StyleID  UNIQUEIDENTIFIER
DECLARE @StyleColorDel1 INT
DECLARE @StyleColorDel2 INT
DECLARE @StyleColorDel3 INT 
DECLARE @StyleColorDel4 INT 
DECLARE @StyleColorCollection  NVARCHAR(200)
DECLARE @Units INT 
DECLARE @SeasonYearID UNIQUEIDENTIFIER 
DECLARE @ColorType  NVARCHAR(5)
DECLARE @SampleStatus INT
DECLARE @ProdStatus INT 

DECLARE @Msg VARCHAR(8000) 
SET @Msg = 'OUTPUT'



BEGIN TRANSACTION 

PRINT @Query
EXEC (@Query)

SELECT @StyleColorId = a.StyleColorwayID, @StyleID = a.StyleID, 
@StyleColorDel1 = a.StyleColorDelivery1, @StyleColorDel2 = a.StyleColorDelivery2, 
@StyleColorDel3 = a.StyleColorDelivery3, @StyleColorDel4 = a.StyleColorDelivery4,
@StyleColorCollection = a.CustomField1, @Units = a.Units,  
@ColorType = a.ColorType, @SampleStatus  = a.SampleStatus, @ProdStatus = a.StyleColorStatus,
@SeasonYearID  = b.SeasonYearID 
FROM pStyleColorwaySeasonyear a 
INNER JOIN pStyleSeasonYear b ON a.StyleSeasonYearID = b.StyleSeasonYearID 
WHERE StyleColorwaySeasonYearID =  @StyleColorwaySeasonYearID 

	
EXEC spx_StyleColorwayDeliveryStatus_INSERT @StyleColorID = @StyleColorID,
@StyleID=@StyleID, @StyleColorDel1 = @StyleColorDel1, @StyleColorDel2 = @StyleColorDel2,
@StyleColorDel3 = @StyleColorDel3, @StyleColorDel4 = @StyleColorDel4, 
@MUser=@MUser, @MDate = @MDate ,@StyleColorCollection=@StyleColorCollection,
@Units = @Units, @SeasonYearID = @SeasonYearID,
@ColorType = @ColorType, @SampleStatus = @SampleStatus , @ProdStatus = @ProdStatus,
@outputMsg  = @Msg OUTPUT 


IF @Msg  =  ''
BEGIN 
	COMMIT TRANSACTION 		
	SELECT '' AS Msg
END
ELSE 
BEGIN
	ROLLBACK TRANSACTION
	SELECT @Msg AS Msg

END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01594'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01594', GetDate())
END	

GO

