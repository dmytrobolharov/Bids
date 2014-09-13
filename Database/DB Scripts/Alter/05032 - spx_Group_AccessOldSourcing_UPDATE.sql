/****** Object:  StoredProcedure [dbo].[spx_Group_AccessOldSourcing_UPDATE]    Script Date: 02/11/2013 16:29:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessOldSourcing_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessOldSourcing_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessOldSourcing_UPDATE]    Script Date: 02/11/2013 16:29:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Group_AccessOldSourcing_UPDATE]  (
@AccessRoleId int  , 
@AccessView int , 
@AccessCreate int , 
@AccessModify int, 
@AccessDelete int , 
@AccessPrint int , 
@GroupID uniqueidentifier , 
@MUser nvarchar (200), 
@MDate  datetime , 
@AccessOldSourcingID uniqueidentifier 
)
AS 

	UPDATE sAccessGroupOldSourcing
	SET AccessRoleId = @AccessRoleId, 
	AccessView = @AccessView,  
	AccessCreate = @AccessCreate,  
	AccessModify = @AccessModify, 
	AccessDelete = @AccessDelete,  
	AccessPrint = @AccessPrint,  
	GroupID = @GroupID, 
	MUser = @MUser,  
	MDate = @MDate  
	WHERE AccessOldSourcingID = @AccessOldSourcingID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05032', GetDate())
GO
