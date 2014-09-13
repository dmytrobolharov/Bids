IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_StyleItem_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_StyleItem_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_LinePlan_StyleItem_DELETE] (
@LinePlanItemID UNIQUEIDENTIFIER,
@StyleSeasonYearID NVARCHAR(40) 
)
AS

BEGIN
   UPDATE pLinePlanItem Set StyleID = '00000000-0000-0000-0000-000000000000' WHERE LinePlanItemID = @LinePlanItemID
END

BEGIN

	IF @StyleSeasonYearID  IS NULL OR @StyleSeasonYearID = ''
		UPDATE pStyleSeasonYear Set LinePlanID = NULL, LinePlanItemID = NULL WHERE LinePlanItemID = @LinePlanItemID
	ELSE 
		UPDATE pStyleSeasonYear Set LinePlanID = NULL, LinePlanItemID = NULL WHERE StyleSeasonYearID = @StyleSeasonYearID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '722', GetDate())
GO
