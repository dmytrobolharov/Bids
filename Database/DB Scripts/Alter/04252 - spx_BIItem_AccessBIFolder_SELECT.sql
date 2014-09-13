IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BIItem_AccessBIFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_SELECT] (   
@GroupID uniqueidentifier,
@BITypeID int  
)  
AS   
  
  
SELECT *  
FROM  sAccessBIItems  
WHERE GroupID = @GroupID  AND BITypeID = @BITypeID 
AND (ItemID IN (select ReportFolderItemID from rReportFolderItem) OR ItemID IN (select DashFolderItemID from rDashFolderItem))
ORDER BY [Description] 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04252', GetDate())
GO
