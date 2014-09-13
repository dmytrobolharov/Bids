/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_Root_UPDATE]    Script Date: 05/24/2014 22:40:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_Root_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_Root_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_Root_UPDATE]    Script Date: 05/24/2014 22:40:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_Root_UPDATE](
	@templateid uniqueidentifier	
)
AS 

DECLARE 
@Name NVArchar(100),
@startDate datetime,
@endDate datetime
	
	SELECT @Name=TACalTemplateName, @startDate=TACalTemplatePlanStart, @endDate=TACalTemplatePlanEnd  from pTACalTemplate where TACalTemplateId=@templateid 
	
	UPDATE pTACalTemplateTask set TaskName = @Name, TaskPlanStart=@startDate, TaskPlanEnd = @endDate, TaskDuration = DATEDIFF(day, @startdate, @enddate) where TACalTemplateId=@templateid and TaskId = 1
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07741', GetDate())
GO