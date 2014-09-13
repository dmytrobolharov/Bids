IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBIFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessBIFolderCheck_INSERT]
GO
     
CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBIFolderCheck_INSERT] (        
@AccessBIId uniqueidentifier,       
@AccessRoleId int,      
@BITypeID int,      
@GroupID uniqueidentifier,     
@TeamID uniqueidentifier,     
@CreatedBy nvarchar(200),        
@CreatedDate datetime        
)        
AS        
        
DECLARE @I as int        
DECLARE @Row_Count int        
DECLARE @BITypeIDVal int        
      
DECLARE @I_WF as int        
DECLARE @Row_Count_WF int        
DECLARE @ItemIDVal uniqueidentifier       
DECLARE @ItemIDValDesc nvarchar(200)   
       
DECLARE @DeskAccessId int        
DECLARE @DeskTableName varchar(100)        
DECLARE @DeskTableKey varchar(50)        
        
        
 --BEGIN        
 --CREATE TABLE #TempGroupAccess (        
 -- Id int IDENTITY (1, 1) NOT NULL ,         
 -- BITypeID int NOT NULL,        
 -- GroupID uniqueidentifier         
 --)         
 --END        
        
 BEGIN        
         
 --INSERT INTO #TempGroupAccess( BITypeID) SELECT BITypeID FROM sAccessBIFolder        
         
         
 --SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)        
    
  SET @Row_Count = 2  
         
 SET @I = 1        
        
 WHILE @I <= @Row_Count         
  BEGIN        
        
   SELECT @BITypeIDVal = @I         
   IF (SELECT COUNT(*) FROM sAccessBIFolder WITH (NOLOCK) WHERE BITypeId = @BITypeIDVal  AND GroupID = @GroupID ) = 0        
   BEGIN        
    INSERT INTO sAccessBIFolder        
     ( BITypeId, GroupID, CUser, CDate, MUser, MDate, TeamID)        
    VALUES(@BITypeIDVal, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID)  
    --SELECT @BITypeIDVal, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate         
    --FROM  #TempGroupAccess WHERE Id = @I        
   END        
            
   SET @I = @I + 1        
  END        
   END     
  --SELECT * FROM #tempGroupAccess        
IF @BITypeID = 1 
 BEGIN
 CREATE TABLE #TempItemAccessDashBoard (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  ItemID uniqueidentifier,  
  [Description] nvarchar(200)        
 )        
   
        
 BEGIN       
    
         
 INSERT INTO #TempItemAccessDashBoard(ItemID, [Description]) SELECT DashFolderItemID, DashFolderItemName  FROM rDashFolderItem         
         
         
 SET @Row_Count_WF = (SELECT COUNT(*) FROM #TempItemAccessDashBoard)        
         
 SET @I_WF = 1        
        
 WHILE @I_WF <= @Row_Count_WF         
  BEGIN        
        
   SELECT @ItemIDVal = ItemID, @ItemIDValDesc = [Description] FROM #TempItemAccessDashBoard WHERE ID = @I_WF        
   IF (SELECT COUNT(*) FROM  sAccessBIItems WITH (NOLOCK) WHERE BITypeId = @BITypeID  AND GroupID = @GroupID AND ItemID = @ItemIDVal) = 0        
   BEGIN        
    INSERT INTO sAccessBIItems        
     ( AccessBIId, AccessRoleId, BITypeId, GroupID, ItemID, CUser, CDate, MUser, MDate, [Description])        
    SELECT @AccessBIId, @AccessRoleId, @BITypeID, @GroupID, ItemID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, [Description]         
    FROM  #TempItemAccessDashBoard WHERE Id = @I_WF        
   END        
            
   SET @I_WF = @I_WF + 1        
  END        
        
  SELECT * FROM #TempItemAccessDashBoard     
END  
END   
  ----REPORT INSERT... 
ELSE
 
BEGIN
DECLARE @I_WF_RP as int        
DECLARE @Row_Count_WF_RP int        
DECLARE @ItemIDValRP uniqueidentifier       
DECLARE @ItemIDValDescRP nvarchar(200)   
    
  CREATE TABLE #TempItemAccessReport (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  ItemID uniqueidentifier,  
  [Description] nvarchar(200)        
 )         
       
        
 BEGIN       
    
         
 INSERT INTO #TempItemAccessReport(ItemID, [Description]) SELECT ReportFolderItemID, ReportItemName  FROM rReportFolderItem         
         
         
 SET @Row_Count_WF_RP = (SELECT COUNT(*) FROM #TempItemAccessReport)        
         
 SET @I_WF_RP = 1        
        
 WHILE @I_WF_RP <= @Row_Count_WF_RP         
  BEGIN        
        
   SELECT @ItemIDValRP = ItemID, @ItemIDValDescRP = [Description] FROM #TempItemAccessReport WHERE ID = @I_WF_RP     
   IF (SELECT COUNT(*) FROM  sAccessBIItems WITH (NOLOCK) WHERE BITypeId = @BITypeID  AND GroupID = @GroupID AND ItemID = @ItemIDValRP) = 0        
   BEGIN        
    INSERT INTO sAccessBIItems        
     ( AccessBIId, AccessRoleId, BITypeId, GroupID, ItemID, CUser, CDate, MUser, MDate, [Description])        
    SELECT @AccessBIId, @AccessRoleId, @BITypeID, @GroupID, ItemID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, [Description]         
    FROM  #TempItemAccessReport WHERE Id = @I_WF_RP        
   END        
            
   SET @I_WF_RP = @I_WF_RP + 1        
  END        
        
  SELECT * FROM #TempItemAccessReport      
  END  
 END 
   
------------New Changes------------------  

IF @BITypeID = 1  
BEGIN
DECLARE @I_WF_2 as int        
DECLARE @Row_Count_WF_2 int        
DECLARE @BIItemFolderIDVal uniqueidentifier    
DECLARE @BIItemIDValDesc nvarchar(200)  
     
CREATE TABLE #TempBIItemFolderAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  ItemID uniqueidentifier,  
  [Description] nvarchar(200)        
 )         
         
        
 BEGIN        
         
 INSERT INTO #TempBIItemFolderAccess(ItemID, [Description]) SELECT DashFolderItemID, DashFolderItemName  FROM rDashFolderItem          
         
         
 SET @Row_Count_WF_2 = (SELECT COUNT(*) FROM #TempBIItemFolderAccess)        
         
 SET @I_WF_2 = 1        
        
 WHILE @I_WF_2 <= @Row_Count_WF_2         
  BEGIN        
        
   SELECT @BIItemFolderIDVal = ItemID, @BIItemIDValDesc = [Description] FROM #TempBIItemFolderAccess WHERE ID = @I_WF_2        
   IF (SELECT COUNT(*) FROM sAccessBIItemsFolder WITH (NOLOCK) WHERE BITypeId = @BITypeID  AND GroupID = @GroupID AND ItemID = @BIItemFolderIDVal) = 0        
   BEGIN        
    INSERT INTO sAccessBIItemsFolder        
     ( AccessBIId, AccessRoleId, BITypeId, GroupID, ItemID, CUser, CDate, MUser, MDate, TeamId, [Description])        
    SELECT @AccessBIId, @AccessRoleId, @BITypeID, @GroupID, ItemID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID, [Description]         
    FROM  #TempBIItemFolderAccess WHERE Id = @I_WF_2       
          
   END        
            
   SET @I_WF_2 = @I_WF_2 + 1        
  END        
        
  SELECT * FROM #TempBIItemFolderAccess      
   END  
   END
  -----Report Insert----  
  ELSE
  BEGIN
 --IF @BITypeID = 2
  DECLARE @I_WF_2_RP as int        
DECLARE @Row_Count_WF_2_RP int        
DECLARE @BIItemFolderIDValRP uniqueidentifier    
DECLARE @BIItemIDValDescRP nvarchar(200)  
     
CREATE TABLE #TempBIItemFolderAccessRP (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  ItemID uniqueidentifier,  
  [Description] nvarchar(200)        
 )         
        
        
 BEGIN        
         
 INSERT INTO #TempBIItemFolderAccessRP(ItemID, [Description]) SELECT ReportFolderItemID, ReportItemName  FROM rReportFolderItem           
         
         
 SET @Row_Count_WF_2_RP = (SELECT COUNT(*) FROM #TempBIItemFolderAccessRP)        
         
 SET @I_WF_2_RP = 1        
        
 WHILE @I_WF_2_RP <= @Row_Count_WF_2_RP         
  BEGIN        
        
   SELECT @BIItemFolderIDValRP = ItemID, @BIItemIDValDescRP = [Description] FROM #TempBIItemFolderAccessRP WHERE ID = @I_WF_2_RP        
   IF (SELECT COUNT(*) FROM sAccessBIItemsFolder WITH (NOLOCK) WHERE BITypeId = @BITypeID  AND GroupID = @GroupID AND ItemID = @BIItemFolderIDValRP) = 0        
   BEGIN        
    INSERT INTO sAccessBIItemsFolder        
     ( AccessBIId, AccessRoleId, BITypeId, GroupID, ItemID, CUser, CDate, MUser, MDate, TeamId, [Description])        
    SELECT @AccessBIId, @AccessRoleId, @BITypeID, @GroupID, ItemID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID, [Description]         
    FROM  #TempBIItemFolderAccessRP WHERE Id = @I_WF_2_RP       
          
   END        
            
   SET @I_WF_2_RP = @I_WF_2_RP + 1        
  END        
        
  SELECT * FROM #TempBIItemFolderAccessRP      
   END 
    END
    
    GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '374', GetDate())

GO
    
        
       