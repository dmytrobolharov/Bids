/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowLogic_UPDATE]    Script Date: 08/12/2014 16:38:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowLogic_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowLogic_UPDATE]    Script Date: 08/12/2014 16:38:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/*

Comments:



This procedure is updated to handle ticket # 1574. 

*/

CREATE   PROCEDURE [dbo].[spx_StyleWorkflowLogic_UPDATE](
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT ,
@MUser NVARCHAR(200),
@MDate DATETIME 
)
AS


DECLARE @DueDate AS DATETIME 
SELECT @DueDate = DueDate  FROM  pStyleHeader WHERE StyleID = @StyleID

UPDATE pStyleWorkflow 
SET WorkDue = DATEADD ( DAY, -ISNULL(WorkDay,0) , @DueDate ) , 
MUser = @MUser, MDate = @MDate
WHERE StyleID = @StyleID AND StyleSet = @StyleSet 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08757', GetDate())
GO