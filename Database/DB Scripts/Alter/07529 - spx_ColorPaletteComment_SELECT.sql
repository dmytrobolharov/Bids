/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteComment_SELECT]    Script Date: 04/22/2014 15:14:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteComment_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteComment_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteComment_SELECT]    Script Date: 04/22/2014 15:14:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorPaletteComment_SELECT](@ColorPaletteID uniqueidentifier)
AS 

SELECT *
FROM  pColorPaletteComment
WHERE ColorPaletteID  = @ColorPaletteID
order by MDate Desc

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07529', GetDate())
GO
