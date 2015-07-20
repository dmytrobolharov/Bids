IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackStyleVariation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
	@StyleID [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
DECLARE @StyleDevelopmentId uniqueidentifier

BEGIN
SELECT TOP 1 @StyleDevelopmentId = StyleDevelopmentId FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID
END

BEGIN
	SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleDevelopmentID, StyleID, StyleDevelopmentName, Variation 
	FROM dbo.pStyleDevelopmentItem WITH (NOLOCK)
	WHERE (StyleDevelopmentID = @StyleDevelopmentID)
	ORDER BY Variation ASC
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03765', GetDate())
GO