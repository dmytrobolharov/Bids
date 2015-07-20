
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
VALUES     ('DB_Version', '2.6.9999', '049', GetDate())
GO