/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImages_SELECT_API]    Script Date: 11/15/2013 13:13:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImages_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImages_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImages_SELECT_API]    Script Date: 11/15/2013 13:13:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleColorwayImages_SELECT_API](
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER

SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear
WHERE StyleID=@StyleID and SeasonYearID=@SeasonYearID

BEGIN

	--Colorway Front
	SELECT sci.StyleColorwaySeasonYearID as StyleImageItemID,sci.DesignImageFrontID as ImageID,sci.DesignImageFrontVersion as ImageVersion, pimage.ImageFile, pImage.CDate,'Colorway Front' as workflowtype, '1' as StyleSet, ColorName as description FROM pStyleColorwaySeasonYear sci  WITH(NOLOCK) LEFT OUTER JOIN 
	pImage ON pImage.ImageID = sci.DesignImageFrontID
	INNER JOIN dbo.pStyleColorway A ON sci.StyleColorwayID = A.StyleColorID       
    INNER JOIN pColorPalette AS E ON A.ColorPaletteID = E.ColorPaletteID   
	WHERE sci.StyleID = @StyleID 
	and (((pImage.ImageFileType = 'AI' or pImage.ImageType='ai') and not sci.DesignImageFrontID='00000000-0000-0000-0000-000000000000') or sci.DesignImageFrontID='00000000-0000-0000-0000-000000000000') 
	and sci.StyleSeasonYearID = @StyleSeasonYearID
	UNION
	--Colorway Back
	SELECT sci.StyleColorwaySeasonYearID as StyleImageItemID,sci.DesignImageBackID as ImageID,sci.DesignImageBackVersion as ImageVersion, pimage.ImageFile, pImage.CDate,'Colorway Back' as workflowtype, '1' as StyleSet, ColorName as description FROM pStyleColorwaySeasonYear sci  WITH(NOLOCK) INNER JOIN 
	pImage ON pImage.ImageID = sci.DesignImageBackID
	INNER JOIN dbo.pStyleColorway A ON sci.StyleColorwayID = A.StyleColorID       
	INNER JOIN pColorPalette AS E ON A.ColorPaletteID = E.ColorPaletteID   
	WHERE sci.StyleID = @StyleID 
	and (pImage.ImageFileType = 'AI' or pImage.ImageType='ai')
	and Not sci.DesignImageBackID = '00000000-0000-0000-0000-000000000000'
	and sci.StyleSeasonYearID = @StyleSeasonYearID
	ORDER BY CDate
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06601', GetDate())
GO
