IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_LinePlanItemStyleUnlink_UPDATE') 
	DROP PROCEDURE spx_LinePlanItemStyleUnlink_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemStyleUnlink_UPDATE](
@StyleID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200), 
@MDate DATETIME 
)
AS



DECLARE @OldLinePlanItemID UNIQUEIDENTIFIER   
DECLARE @OldLinePlanID UNIQUEIDENTIFIER   
DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER   

DECLARE @OldLinePlanAttributeItemId1 NVARCHAR(50)
DECLARE @OldLinePlanAttributeItemId2 NVARCHAR(50)
DECLARE @OldLinePlanAttributeItemId3 NVARCHAR(50)
DECLARE @OldLinePlanAttributeItemId4 NVARCHAR(50)


      
/***
** Get LineplanItem 
***/
SELECT @OldLinePlanID= a.LinePlanID, @OldLinePlanItemID  = a.LinePlanItemID, 
@OldLinePlanAttributeItemId1 = c.LinePlanAttributeItemId1, @OldLinePlanAttributeItemId2 = c.LinePlanAttributeItemId2, 
@OldLinePlanAttributeItemId3 = c.LinePlanAttributeItemId3, @OldLinePlanAttributeItemId4 = c.LinePlanAttributeItemId4, 
@LinePlanTemplateID =  d.LinePlanTemplateID 
FROM pStyleSeasonYear a
INNER JOIN pLinePlanItem b ON a.LinePlanItemID =  b.LinePlanItemID 
INNER JOIN pLinePlanRange c ON b.LinePlanRangeID = c.LinePlanRangeID 
INNER JOIN pLinePlan d On d.LinePlanID = b.LinePlanID 
WHERE a.StyleID = @StyleID 
AND a.SeasonYearID = @SeasonYearID 



UPDATE pStyleSeasonYear 
SET LinePlanID = NULL, LinePlanItemID = NULL
WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID 


IF @OldLinePlanItemID  IS NOT NULL
BEGIN


      DECLARE @Index INT 
      
      SELECT @Index = COUNT(*)  FROM pLinePlanTemplateItem  
      WHERE LinePlanTemplateID = @LinePlanTemplateID
      
            
      /***
      ** Update old lineplanitem 
      ***/
      UPDATE pLinePlanItem Set StyleID = '00000000-0000-0000-0000-000000000000',
      MUser = @MUser, MDate =  @MDate 
      WHERE LinePlanItemID = @OldLinePlanItemID
      
      
      DELETE FROM pLineplanBusinessItem WHERE StyleID = @StyleID AND LinePlanID = @OldLinePlanID
      DELETE FROM pLinePlanShowroomStyle WHERE StyleID = @StyleID
      DELETE FROM pLinePlanShowroomStyleColor WHERE StyleID = @StyleID AND LinePlanID = @OldLinePlanID

      IF @Index = 3 
            SET @OldLinePlanAttributeItemId4 = ''

      EXEC spx_LinePlanBusinessItemRollup_INSERT @LinePlanId = @OldLinePlanId,
      @LinePlanAttributeItemId1 = @OldLinePlanAttributeItemId1,
      @LinePlanAttributeItemId2 = @OldLinePlanAttributeItemId2,
      @LinePlanAttributeItemId3 = @OldLinePlanAttributeItemId3,
      @LinePlanAttributeItemId4 = @OldLinePlanAttributeItemId4,
      @Cmd = '',
      @StyleSeasonYearID  = NULL 

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01532', GetDate())
GO