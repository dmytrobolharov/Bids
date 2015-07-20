/****** Object:  StoredProcedure [dbo].[spx_Group_AccessOldSourcing_SELECT]    Script Date: 02/11/2013 15:59:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessOldSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessOldSourcing_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessOldSourcing_SELECT]    Script Date: 02/11/2013 15:59:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Group_AccessOldSourcing_SELECT] ( 
@GroupID uniqueidentifier
)
AS 


SELECT a.StyleTypeID, a.StyleTypeDescription, 
	b.AccessOldSourcingID,  b.AccessRoleId, b.AccessView, b.AccessCreate, 
	b.AccessModify, b.AccessDelete, b.AccessPrint, 
	b.GroupID, b.CUser, b.CDate,  b.MUser, 
	b.MDate, a.StyleTypeOrder
FROM  pStyleType a WITH (NOLOCK) INNER JOIN   sAccessGroupOldSourcing b WITH (NOLOCK) ON a.StyleTypeID = b.StyleTypeID
WHERE b.GroupID = @GroupID
ORDER BY a.StyleTypeOrder

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05031', GetDate())
GO
