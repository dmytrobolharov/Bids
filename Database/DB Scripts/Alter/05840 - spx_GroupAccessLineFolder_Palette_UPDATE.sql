/****** Object:  StoredProcedure [dbo].[spx_GroupAccessLineFolder_Palette_UPDATE]    Script Date: 06/11/2013 16:33:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GroupAccessLineFolder_Palette_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GroupAccessLineFolder_Palette_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_GroupAccessLineFolder_Palette_UPDATE]    Script Date: 06/11/2013 16:33:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_GroupAccessLineFolder_Palette_UPDATE]  (  
@AccessRoleId	INT,   
@AccessView		INT,   
@AccessCreate	INT ,   
@AccessModify	INT,  
@AccessDelete	INT ,   
@AccessPrint	INT , 
@MUser			NVARCHAR (200),   
@MDate			DATETIME ,   
@AccessLinePaletteID UNIQUEIDENTIFIER   
)  
AS

DECLARE @AccessLineId UNIQUEIDENTIFIER
DECLARE @GroupID UNIQUEIDENTIFIER
DECLARE @LineTypeID UNIQUEIDENTIFIER

SELECT @AccessLineId = AccessLineID, @GroupID = GroupID, @LineTypeID = LineTypeID 
FROM sAccessGroupLineFolderPalette WHERE AccessLinePaletteID = @AccessLinePaletteID


EXEC spx_Group_DesktopAccessLineFolderPaletteCheck_INSERT @AccessLineID, @AccessRoleID, @LineTypeID, @GroupID, @MUser, @MDate
  
 UPDATE sAccessGroupLineFolderPalette    
 SET AccessRoleId = @AccessRoleId,   
 AccessView = @AccessView,    
 AccessCreate = @AccessCreate,    
 AccessModify = @AccessModify, 
 AccessDelete = @AccessDelete,    
 AccessPrint = @AccessPrint,   
 MUser = @MUser,    
 MDate = @MDate    
 WHERE AccessLinePaletteID = @AccessLinePaletteID
 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05840', GetDate())
GO
