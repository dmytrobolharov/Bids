/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]    Script Date: 07/11/2013 13:51:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemStyleWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]    Script Date: 07/11/2013 13:51:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]
(
@StyleID uniqueidentifier,
@TeamID uniqueidentifier,
@SeasonYearID uniqueidentifier
)
AS 

DECLARE @DevelopmentId uniqueidentifier
SELECT @DevelopmentId = DevelopmentId FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId

DECLARE @StyleTypeId INT
SELECT @StyleTypeId = StyleType FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId

DECLARE @StyleWorkflowID as uniqueidentifier  
SELECT @StyleWorkflowID = StyleWorkflowId  FROM pStyleHeader WITH (NOLOCK) where StyleID = @StyleID

DECLARE @intCount INT
DECLARE @EnableOldCosting VARCHAR(10)

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear
WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

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
	INNER JOIN dbo.pWorkflowTemplateItem WITH (NOLOCK) ON  pWorkflowTemplateItem.WorkflowID  = Mapping.Map
WHERE     (pStyleWorkflow.StyleID = @StyleID) AND (pStyleWorkflow.StyleSet = 1) 
			AND pWorkflowTemplateItem.WorkflowTemplateID = @StyleWorkflowID and 
			pWorkflowTemplateItem.WorkflowID <> '70000000-0000-0000-0000-000000000001'
			AND (pStyleWorkflow.StyleSeasonYearID = @StyleSeasonYearID OR pStyleWorkflow.StyleSeasonYearID IS NULL)
ORDER BY pStyleWorkflow.WorkSort


INSERT INTO #TempLineWorkflow
    (Map, MapDetail, Sort, StyleId, DevelopmentId)
SELECT Mapping.Map, Mapping.MapDetail, '0000', @StyleID, @DevelopmentID
from Mapping
where Mapping.Map='70000000-0000-0000-0000-000000000001'

SELECT @intCount=COUNT(*) FROM sAccessCosting WHERE 	StyleTypeId = @StyleTypeId 
AND TeamId = @TeamID

SELECT @EnableOldCosting = AppSettingValue FROM sAppSetting WHERE AppSettingKey='ShowOldStyleCosting'

IF @intCount>0 AND UPPER(@EnableOldCosting) = 'TRUE'
BEGIN
	INSERT INTO #TempLineWorkflow
		(Map, MapDetail, StyleId, DevelopmentId)
	VALUES
		('{50000000-0000-0000-0000-000000000005}', 'Costing', @StyleId, @DevelopmentId)
END

SELECT Map, MapDetail, StyleId, DevelopmentId FROM #TempLineWorkflow

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06035', GetDate())
GO
