IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWFValidation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWFValidation_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ImageWFValidation_SELECT] ( 
@WorkflowID uniqueidentifier
)

AS SELECT *
FROM         dbo.pImageWFValidation
WHERE  WorkflowID = @WorkflowID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03187', GetDate())

GO    
    