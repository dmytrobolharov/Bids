IF OBJECT_ID(N'[dbo].[spx_GRMPOMTemplateDivisions_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_GRMPOMTemplateDivisions_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_GRMPOMTemplateDivisions_INSERT]
	@POMTemplateID UNIQUEIDENTIFIER, 
	@DivisionsList nVARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pGRMPOMTemplateDivisions 
	WHERE GRMPOMTemplateID = @POMTemplateID
	
	INSERT INTO pGRMPOMTemplateDivisions (GRMPOMTemplateID, DivisionID)
	SELECT @POMTemplateID, LTRIM(RTRIM(value))
	FROM dbo.fnx_Split(@DivisionsList,',')

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09263', GetDate())

GO
