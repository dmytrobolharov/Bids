/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowAllLogic_UPDATE]    Script Date: 05/12/2014 15:39:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowAllLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowAllLogic_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowAllLogic_UPDATE]    Script Date: 05/12/2014 15:39:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create   PROCEDURE [dbo].[spx_StyleWorkflowAllLogic_UPDATE](
@StyleID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME 
)
AS


DECLARE @DueDate AS DATETIME 
SELECT @DueDate = DueDate  FROM  pStyleHeader WHERE StyleID = @StyleID

UPDATE pStyleWorkflow 
SET WorkDue = DATEADD ( DAY, -ISNULL(WorkDay,0) , @DueDate ) , 
MUser = @MUser, MDate = @MDate
WHERE StyleID = @StyleID 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07596', GetDate())
GO