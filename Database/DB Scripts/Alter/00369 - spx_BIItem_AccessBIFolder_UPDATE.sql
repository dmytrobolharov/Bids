IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BIItem_AccessBIFolder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_BIItem_AccessBIFolder_UPDATE]  (  
@AccessRoleId int  ,   
@AccessView int ,   
@AccessCreate int ,   
@AccessModify int,   
@AccessRemove int ,   
@AccessDelete int ,   
@AccessPrint int , 
@MUser nvarchar (200),   
@MDate  datetime ,   
@AccessBIItemID uniqueidentifier   
)  
AS   
  
 UPDATE sAccessBIItems    
 SET AccessRoleId = @AccessRoleId,   
 AccessView = @AccessView,    
 AccessCreate = @AccessCreate,    
 AccessModify = @AccessModify,   
 AccessRemove = @AccessRemove,   
 AccessDelete = @AccessDelete,    
 AccessPrint = @AccessPrint,   
 MUser = @MUser,    
 MDate = @MDate    
 WHERE AccessBIItemID = @AccessBIItemID
 
 GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '369', GetDate())

GO