
CREATE PROCEDURE [dbo].[spx_LinePlan_StyleItem_DELETE] (
@LinePlanItemID UNIQUEIDENTIFIER,
@StyleSeasonYearID UNIQUEIDENTIFIER 
)
AS

BEGIN
   UPDATE pLinePlanItem Set StyleID = '00000000-0000-0000-0000-000000000000' WHERE LinePlanItemID = @LinePlanItemID
END

BEGIN
   UPDATE pStyleSeasonYear Set LinePlanID = NULL, LinePlanItemID = NULL WHERE StyleSeasonYearID = @StyleSeasonYearID
END

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '048', GetDate())
GO