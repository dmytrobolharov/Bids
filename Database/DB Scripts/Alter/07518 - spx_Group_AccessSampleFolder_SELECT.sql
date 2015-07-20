/****** Object:  StoredProcedure [dbo].[spx_Group_AccessSampleFolder_SELECT]    Script Date: 04/18/2014 14:33:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessSampleFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessSampleFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessSampleFolder_SELECT]    Script Date: 04/18/2014 14:33:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessSampleFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 

	Select a.SampleWorkflowID as SampleTypeID ,  a.SampleWorkflow as SampleTypeDescription ,
		b.AccessSampleId, b.AccessRoleId, b.AccessView, b.AccessCreate, 
		b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove, 
		b.GroupID, b.CUser, b.CDate, b.MUser, 
		b.MDate , a.SampleWorkflowSort
	FROM  pSampleWorkflow a WITH (NOLOCK) INNER JOIN sAccessGroupSampleFolder b WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleTypeID
	WHERE b.GroupID = @GroupID
	AND ltrim(rtrim(lower(a.Active)))  =  'yes' 
	ORDER BY a.SampleWorkflowSort

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07518', GetDate())
GO