
ALTER PROCEDURE [dbo].[spx_Group_DesktopAccessFolder_UPDATE] (  
@DeskGroupAccessId uniqueidentifier,  
@DeskAccessId int,  
@mUser nvarchar(200),  
@mDate datetime  
)  
AS
DECLARE @DeskFolderId int  
DECLARE @GroupID  uniqueidentifier  
  
SELECT @DeskFolderId = DeskFolderId, 
       @GroupID     = GroupID 
 FROM  cDeskGroupFolderAccess   
WHERE  DeskGroupAccessId = @DeskGroupAccessId  
  
UPDATE  cDeskGroupFolderAccess  
   SET  DeskAccessId = @DeskAccessId,
               MUser = @mUser,
               MDate = @mDate  
 WHERE  DeskGroupAccessId = @DeskGroupAccessId  
  
--  
--  RESET PERMISIONS FOR USERS
--
   
IF @DeskAccessId  =  0   
BEGIN   
  
 IF  @DeskFolderId  = 2    
 BEGIN  
  DELETE FROM sAccessGroupStyleFolder where GroupID=  @GroupID   
  DELETE FROM sAccessStyleFolder where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END   
  
 ELSE IF @DeskFolderId  = 3  
 BEGIN   
  DELETE FROM sAccessGroupLineFolder where GroupID=  @GroupID   
  DELETE FROM sAccessLineFolder where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )    
 END   
   
 ELSE IF @DeskFolderId  = 4  
 BEGIN   
  DELETE FROM sAccessGroupQuotationFolder  where GroupID=  @GroupID   
  DELETE FROM sAccessQuotationFolder  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END   
  
 ELSE IF @DeskFolderId  = 5  
 BEGIN   
  DELETE FROM sAccessGroupSampleFolder  where GroupID=  @GroupID   
  DELETE FROM sAccessSampleFolder  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END   
  
 ELSE IF @DeskFolderId  = 6  
 BEGIN  
  DELETE FROM sAccessGroupImageFolder  where GroupID=  @GroupID   
  DELETE FROM sAccessImageFolder  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
  
 END   
  
 ELSE IF @DeskFolderId  = 7  
 BEGIN   
  DELETE FROM sAccessGroupColorFolder  where GroupID=  @GroupID   
  DELETE FROM sAccessColorFolder  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END  
  
 ELSE IF @DeskFolderId  = 8  
 BEGIN  
  DELETE FROM sAccessGroupMaterialFolder where GroupID=  @GroupID   
  DELETE FROM sAccessMaterialFolder where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END  
  
 ELSE IF @DeskFolderId  = 9  
 BEGIN  
  DELETE FROM sAccessGroupComplianceFolder  where GroupID=  @GroupID   
  DELETE FROM sAccessComplianceFolder  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END  
  
 ELSE IF @DeskFolderId  = 10  
 BEGIN  
  DELETE FROM sAccessGroupControlPanel  where GroupID=  @GroupID   
  DELETE FROM sAccessControlPanel  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )   
 END  
  
 ELSE IF @DeskFolderId  = 11  
 BEGIN   
  DELETE FROM sAccessGroupShareFolder  where GroupID=  @GroupID   
  DELETE FROM sAccessShareFolder  where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )    
 END  
 ELSE IF @DeskFolderId  = 12  
 BEGIN   
  DELETE FROM sAccessGroupCosting where GroupID=  @GroupID   
  DELETE FROM sAccessCosting where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )    
 END  
ELSE IF @DeskFolderId  = 14  
 BEGIN   
  DELETE FROM sAccessGroupBodyFolder where GroupID=  @GroupID   
  DELETE FROM sAccessBodyFolder where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )    
 END 
ELSE IF @DeskFolderId  = 15 
 BEGIN   
  DELETE FROM sAccessGroupQuickBatchReplaceFolder where GroupID=  @GroupID   
  DELETE FROM sAccessQuickBatchReplaceFolder where TeamID IN  ( SELECT DISTINCT TeamID from uUserGroup where GroupID=  @GroupID )    
 END   
  
END   
    
UPDATE cDeskUserFolderAccess 
   SET DeskAccessId = @DeskAccessId
 WHERE DeskFolderId = @DeskFolderId 
   AND TeamID IN ( SELECT DISTINCT TeamID from uUserGroup where GroupID = @GroupID )   
  
If @DeskFolderId = 10  
BEGIN  
 IF @DeskAccessId = 1  
    BEGIN  
         UPDATE sAccessGroupControlPanel 
            SET   AccessRoleId = 0,   
                    AccessView = 0,   
                  AccessCreate = 0,   
                  AccessModify = 0,   
                  AccessDelete = 0,   
                   AccessPrint = 0,  
                         MUser = @mUser,   
                         MDate = @mDate  
          WHERE GroupID = @GroupID  
      END  
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '127', GetDate())
GO
