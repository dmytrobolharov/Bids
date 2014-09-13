/****** Object:  StoredProcedure [dbo].[spx_StyleVariationMenu_SELECT]    Script Date: 12/05/2012 16:08:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariationMenu_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariationMenu_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleVariationMenu_SELECT]    Script Date: 12/05/2012 16:08:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_StyleVariationMenu_SELECT]
(@StyleID uniqueidentifier)
AS 

DECLARE @StyleDevelopmentId varchar(50)
DECLARE @Variation varchar(5)

BEGIN
SELECT @Variation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID
END

BEGIN
SELECT StyleDevelopmentId, Variation, StyleDevelopmentName, Sort
FROM  dbo.pStyleDevelopmentItem WITH (NOLOCK)
GROUP BY Variation, StyleDevelopmentID, StyleDevelopmentName, Sort
HAVING (StyleDevelopmentID = @StyleDevelopmentID AND Variation <> @Variation)
ORDER BY Sort, Variation
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04561', GetDate())
GO
