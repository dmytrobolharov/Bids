IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessBIFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_AccessBIFolder_SELECT]
GO
  
CREATE PROCEDURE [dbo].[spx_AccessBIFolder_SELECT] (   
@GroupID uniqueidentifier  
)  
AS   
  
  
SELECT *  
FROM  sAccessBIFolder  
WHERE sAccessBIFolder.GroupID = @GroupID  
ORDER BY sAccessBIFolder.BITypeDesc  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '367', GetDate())

GO
  
  
  