/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_GetMappingInfo]    Script Date: 03/24/2014 12:54:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_GetMappingInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_GetMappingInfo]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_GetMappingInfo]    Script Date: 03/24/2014 12:54:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflow_GetMappingInfo]
	@WorkflowID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM Mapping WHERE Map = @WorkflowID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07355', GetDate())
GO
