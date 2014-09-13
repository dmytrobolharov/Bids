/****** Object:  StoredProcedure [dbo].[spx_TACalendat_tasks_DELETE]    Script Date: 05/13/2014 18:47:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendat_tasks_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendat_tasks_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendat_tasks_DELETE]    Script Date: 05/13/2014 18:47:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_TACalendat_tasks_DELETE]
	@TACalTemplateId UNIQUEIDENTIFIER
AS
BEGIN
	
	delete from pTACalTemplateTaskdep where TACalTemplateTaskChildId in (select TACalTemplateTaskID from pTACalTemplateTask where TACalTemplateId=@TACalTemplateId)
	delete from pTACalTemplateTask where TACalTemplateId=@TACalTemplateId
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07606', GetDate())
GO