IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserTeamID_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserTeamID_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_UserTeamID_SELECT]    
(    
@TeamID varchar(50)    
)    
AS     
    
BEGIN    
 SELECT *    
 FROM Users    
 WHERE TeamID = @TeamID    
END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '666', GetDate())

GO
