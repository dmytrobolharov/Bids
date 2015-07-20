IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserInStyleOwnerGroup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserInStyleOwnerGroup_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_UserInStyleOwnerGroup_SELECT](
@TeamId nvarchar(50),
@GroupId nvarchar(50)
)

AS 

SELECT  COUNT(uUserGroup.GroupID) as OwnerGroupCnt 
FROM  uUserGroup INNER JOIN uGroup ON uUserGroup.GroupID = uGroup.GroupID 
WHERE uUserGroup.TeamId = @TeamId AND uUserGroup.GroupID=@GroupId                                  

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03206'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03206', GetDate())
END
GO	