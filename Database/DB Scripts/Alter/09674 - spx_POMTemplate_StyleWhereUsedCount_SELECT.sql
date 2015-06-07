IF OBJECT_ID(N'[dbo].[spx_POMTemplate_StyleWhereUsedCount_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_POMTemplate_StyleWhereUsedCount_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_POMTemplate_StyleWhereUsedCount_SELECT]

	(
		@POMTempID uniqueidentifier
	)

AS

BEGIN
	
  SELECT (SELECT COUNT(*) FROM pStyleHeader WITH (NOLOCK) WHERE POMTempID1 = @POMTempId) +
	     (SELECT COUNT(*) FROM pStyleHeader WITH (NOLOCK) WHERE POMTempID2 = @POMTempId) +
		 (SELECT COUNT(*) FROM pStyleHeader WITH (NOLOCK) WHERE POMTempID3 = @POMTempId) +
		 (SELECT COUNT(*) FROM pStyleHeader WITH (NOLOCK) WHERE POMTempID4 = @POMTempId) AS StyleCount

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09674', GetDate())
GO