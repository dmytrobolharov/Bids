/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_Root_UPDATE]    Script Date: 06/02/2014 17:01:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_Root_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_Root_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_Root_UPDATE]    Script Date: 06/02/2014 17:01:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_Root_UPDATE](
	@templateid uniqueidentifier	
)
AS 

DECLARE 
@Name NVArchar(100)

	
	SELECT @Name=TACalTemplateName  from pTACalTemplate where TACalTemplateId=@templateid 
	
	UPDATE pTACalTemplateTask set TaskName = @Name where TACalTemplateId=@templateid and TaskId = 1
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07812', GetDate())
GO