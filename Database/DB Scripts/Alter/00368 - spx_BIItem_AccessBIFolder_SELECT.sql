IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BIItem_AccessBIFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_SELECT] (   
@GroupID uniqueidentifier,
@BITypeID int  
)  
AS   
  
  
SELECT *  
FROM  sAccessBIItems  
WHERE GroupID = @GroupID  AND BITypeID = @BITypeID 
ORDER BY [Description] 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '368', GetDate())

GO