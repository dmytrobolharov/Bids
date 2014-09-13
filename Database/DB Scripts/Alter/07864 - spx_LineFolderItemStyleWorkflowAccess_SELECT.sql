/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]    Script Date: 06/04/2014 13:49:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]    Script Date: 06/04/2014 13:49:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT] ( 
@StyleID uniqueidentifier,
@TeamID uniqueidentifier  
)
AS 

DECLARE @DevelopmentId uniqueidentifier
SELECT @DevelopmentId = DevelopmentId FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId

CREATE TABLE #TempLineWorkflow (
	[LineId] [int] IDENTITY (1, 1) NOT NULL ,
	[Map] [uniqueidentifier] NULL ,
	[MapDetail] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StyleId] [uniqueidentifier] NULL ,
	[DevelopmentId] [uniqueidentifier] NULL ,
	[Sort] [smallint] NULL 
) 


INSERT INTO #TempLineWorkflow
    (Map, MapDetail, Sort, StyleId, DevelopmentId)
SELECT Mapping.Map, Mapping.MapDetail, pStyleWorkflow.WorkSort, @StyleID, @DevelopmentID
FROM pStyleWorkflow WITH (NOLOCK) INNER JOIN
    Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pStyleWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN
    fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
WHERE     (pStyleWorkflow.StyleID = @StyleID) AND (pStyleWorkflow.StyleSet = 1)
AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
ORDER BY pStyleWorkflow.WorkSort


DECLARE @Count AS INT 

SELECT @Count = COUNT(*)  FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, 12) access 
INNER JOIN pStyleHeader ON pStyleHeader.StyleType = access.ProductTypeId AND pStyleHeader.StyleID = @StyleID
WHERE access.PermissionRoleId =  3 OR access.PermissionView = 1


IF  @Count > 0 
BEGIN
	INSERT INTO #TempLineWorkflow
	    (Map, MapDetail, StyleId, DevelopmentId)
	VALUES
		('{50000000-0000-0000-0000-000000000005}', 'Old Costing', @StyleId, @DevelopmentId)

END 



SELECT Map, MapDetail, StyleId, DevelopmentId, Sort FROM #TempLineWorkflow ORDER BY Sort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07864', GetDate())
GO