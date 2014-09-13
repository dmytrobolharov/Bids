/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]    Script Date: 04/09/2013 15:36:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflowAccess_SELECT]    Script Date: 04/09/2013 15:36:05 ******/
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
    pStyleHeader WITH (NOLOCK) ON pStyleWorkflow.StyleID = pStyleHeader.StyleID
WHERE     (pStyleWorkflow.StyleID = @StyleID) AND (pStyleWorkflow.StyleSet = 1)
AND pStyleHeader.StyleType in  (  SELECT  StyleTypeId from sAccessStyleFolder WITH (NOLOCK) where TeamId = @TeamID  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
ORDER BY pStyleWorkflow.WorkSort


DECLARE @Count AS INT 

SELECT @Count = COUNT(*)  FROM sAccessCosting WITH (NOLOCK)
WHERE TeamID  = @TeamID
AND StyleTypeId  =  ( SELECT StyleType FROM pStyleHeader WITH (NOLOCK) WHERE  StyleID = @StyleID   )
AND  ( AccessRoleId =  3 OR AccessView = 1)


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
VALUES     ('DB_Version', '0.5.0000', '05515', GetDate())
GO
