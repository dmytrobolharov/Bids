/****** Object:  StoredProcedure [dbo].[spx_StyleVariationGroup_SELECT]    Script Date: 12/05/2012 15:56:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariationGroup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariationGroup_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleVariationGroup_SELECT]    Script Date: 12/05/2012 15:56:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_StyleVariationGroup_SELECT]
(@StyleDevelopmentID uniqueidentifier)
AS 

/*
Created By Daniel @ 04/24/07 2:23 PM
*/

SELECT  StyleDevelopmentName, StyleDevelopmentID, Variation, Sort
FROM         pStyleDevelopmentItem WITH (NOLOCK)
GROUP BY StyleDevelopmentName, Variation, StyleDevelopmentID, Sort
HAVING      (StyleDevelopmentID = @StyleDevelopmentID)
ORDER BY Sort, Variation

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04559', GetDate())
GO
