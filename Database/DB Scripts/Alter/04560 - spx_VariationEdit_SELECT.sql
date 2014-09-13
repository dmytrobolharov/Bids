/****** Object:  StoredProcedure [dbo].[spx_VariationEdit_SELECT]    Script Date: 12/05/2012 16:08:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VariationEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VariationEdit_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_VariationEdit_SELECT]    Script Date: 12/05/2012 16:08:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_VariationEdit_SELECT]
(@StyleDevelopmentID uniqueidentifier)
AS 
SELECT   COALESCE(StyleDevelopmentName, 'Variation ' + CAST(Variation AS VARCHAR(5))) AS StyleDevelopmentName, StyleDevelopmentID, Variation, Sort
FROM         pStyleDevelopmentItem WITH (NOLOCK)
GROUP BY StyleDevelopmentName, Variation, StyleDevelopmentID, Sort
HAVING      (StyleDevelopmentID = @StyleDevelopmentID)
ORDER BY Sort, Variation


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04560', GetDate())
GO
