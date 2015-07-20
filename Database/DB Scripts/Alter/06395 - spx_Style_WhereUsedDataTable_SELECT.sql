/****** Object:  StoredProcedure [dbo].[spx_Style_WhereUsedDataTable_SELECT]    Script Date: 10/02/2013 14:15:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_WhereUsedDataTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_WhereUsedDataTable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_WhereUsedDataTable_SELECT]    Script Date: 10/02/2013 14:15:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_Style_WhereUsedDataTable_SELECT] (
@StyleID UNIQUEIDENTIFIER
)
AS
select * into #temp1 from (
select wi.WorkFlowItemName as name from pWorkFlowItem wi 
INNER JOIN pWorkFlowItemLinked wl ON wi.WorkFlowItemID=wl.WorkFlowItemID 
INNER JOIN pStyleHeader sh ON  sh.StyleID = wl.StyleID
where wi.StyleID=@StyleID and WorkflowID='40000000-0000-0000-0000-000000000050' 
UNION
select 'Style Model' as name from pStyleWorkflow sw 
INNER JOIN pWorkFlowItemLinked wl ON sw.StyleWorkflowID=wl.WorkFlowItemID
INNER JOIN pStyleHeader sh ON  sh.StyleID = wl.StyleID
  where sw.StyleID=@StyleID and sw.WorkflowID='40000000-0000-0000-0000-000000000037'
UNION
select 'Style Marker' as name from pStyleWorkflow sw 
INNER JOIN pWorkFlowItemLinked wl ON sw.StyleWorkflowID=wl.WorkFlowItemID  
INNER JOIN pStyleHeader sh ON  sh.StyleID = wl.StyleID
where sw.StyleID=@StyleID and sw.WorkflowID='40000000-0000-0000-0000-000000000023'
) as tmp

select * from #temp1 
drop table #temp1
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06395', GetDate())
GO