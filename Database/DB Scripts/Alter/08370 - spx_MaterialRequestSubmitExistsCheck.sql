IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitExistsCheck]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitExistsCheck]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitExistsCheck]
(
@ColorID nvarchar(50),
@WorkflowID nvarchar(5)
)
AS 

BEGIN

SELECT CASE 
	WHEN COUNT(MaterialRequestWorkflowID) = 0
		THEN 0
	ELSE 1
		END
	FROM pMaterialRequestSubmitWorkflow WHERE MaterialRequestWorkflowID = @WorkflowID AND MaterialTradePartnerColorID = @ColorID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08370', GetDate())
GO