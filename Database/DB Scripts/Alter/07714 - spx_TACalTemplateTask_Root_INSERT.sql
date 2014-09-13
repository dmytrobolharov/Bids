/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_Root_INSERT]    Script Date: 05/21/2014 17:21:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_Root_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_Root_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_Root_INSERT]    Script Date: 05/21/2014 17:21:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_Root_INSERT](
	@templateid uniqueidentifier	
)
AS 

DECLARE 
@Name NVArchar(100),
@startDate datetime,
@endDate datetime
	
	SELECT @Name=TACalTemplateName, @startDate=TACalTemplatePlanStart, @endDate=TACalTemplatePlanEnd  from pTACalTemplate where TACalTemplateId=@templateid 
	
	insert into pTACalTemplateTask(TACalTemplateId,taskid, TaskName, TaskPlanStart, TaskPlanEnd, level,active) values(@templateid,1, @Name,@startDate,@endDate,0,1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07714', GetDate())
GO