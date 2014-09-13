IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_StyleShowRoomItem_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_StyleShowRoomItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_StyleShowRoomItem_DELETE] (  
@StyleID UNIQUEIDENTIFIER,  
@LinePlanID UNIQUEIDENTIFIER,   
@LinePlanRangeID UNIQUEIDENTIFIER
)  
AS  

BEGIN

 DELETE FROM pLinePlanShowroomStyleColor WHERE StyleID=@StyleID AND LinePlanID=@LinePlanID AND LinePlanRangeID=@LinePlanRangeID

END 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '723', GetDate())
GO
