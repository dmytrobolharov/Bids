/****** Object:  StoredProcedure [dbo].[spx_Style_WorkflowItemSeasonality_UPDATE]    Script Date: 10/03/2013 13:18:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_WorkflowItemSeasonality_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_WorkflowItemSeasonality_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_WorkflowItemSeasonality_UPDATE]    Script Date: 10/03/2013 13:18:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_Style_WorkflowItemSeasonality_UPDATE]
	 @StyleID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @StyleSeasonYearID uniqueidentifier
	
	SELECT TOP 1 @StyleSeasonYearID= StyleSeasonYearID from pStyleSeasonYear where StyleID=@StyleID
	
	UPDATE pWorkFlowItem set StyleSeasonYearID=@StyleSeasonYearID where StyleID=@StyleID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06422', GetDate())
GO