
/****** Object:  StoredProcedure [dbo].[spx_TACalendar_TaskDep_DELETE]    Script Date: 05/31/2014 23:54:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_TaskDep_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_TaskDep_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_TaskDep_DELETE]    Script Date: 05/31/2014 23:54:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_TaskDep_DELETE]
	@TACalTemplateId UNIQUEIDENTIFIER
AS
BEGIN
	
	delete from pTACalTemplateTaskdep where TACalTemplateTaskChildId in (select TACalTemplateTaskID from pTACalTemplateTask where TACalTemplateId=@TACalTemplateId)
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07790', GetDate())
GO