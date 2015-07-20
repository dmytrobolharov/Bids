IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBICheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessBICheck_INSERT]
GO
  
CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBICheck_INSERT] (  
@GroupID uniqueidentifier,   
@CreatedBy nvarchar(200),  
@CreatedDate datetime,
@TeamID uniqueidentifier  
)  
AS  
  
DECLARE @I as int  
DECLARE @Row_Count int    
DECLARE @BITypeDesc nvarchar(200) 
 
   
 BEGIN  
    
   
 SET @Row_Count = 2
 SET @I = 1  
 
 BEGIN
  IF (SELECT COUNT(*) FROM sAccessBIFolder WITH (NOLOCK) WHERE GroupID = @GroupID ) = 0 
   WHILE @I <= @Row_Count   
   --BEGIN  
   --IF (SELECT COUNT(*) FROM sAccessBIFolder WITH (NOLOCK) WHERE GroupID = @GroupID ) = 0  
   BEGIN  
   IF @I = 1
    INSERT INTO sAccessBIFolder  
     ( BITypeId, BITypeDesc, GroupID, CUser, CDate, MUser, MDate, TeamID) 
     VALUES( @I,'Dashboard',@GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID) 
   ELSE 
     INSERT INTO sAccessBIFolder  
     ( BITypeId, BITypeDesc, GroupID, CUser, CDate, MUser, MDate, TeamID) 
     VALUES( @I,'Report',@GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID) 
    
   SET @I = @I + 1  
   END
   
  END   
 
  
 END  
 
 
 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '373', GetDate())

GO
  
  
  