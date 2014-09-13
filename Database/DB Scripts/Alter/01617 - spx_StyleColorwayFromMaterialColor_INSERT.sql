IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayFromMaterialColor_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorwayFromMaterialColor_INSERT]
GO

CREATE PROCEDURE dbo.spx_StyleColorwayFromMaterialColor_INSERT(
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@MaterialColorID UNIQUEIDENTIFIER, 
	@CUser  NVARCHAR(200), 
	@CDate DATETIME, 
	@AllSizeClasses INT,
	@SeasonYearID UNIQUEIDENTIFIER  = NULL, 
	@ChangeTransID UNIQUEIDENTIFIER = NULL,
	@ChangeTransUserID UNIQUEIDENTIFIER = NULL,
	@ChangeTransPageName NVARCHAR(200) = NULL
)
AS 

DECLARE @ColorPaletteID UNIQUEIDENTIFIER 

SELECT @ColorPaletteID = ColorPaletteID
FROM pMaterialColor WITH(NOLOCK)
WHERE MaterialColorID = @MaterialColorID 


EXEC spx_StyleColorwayFromColor_INSERT
	@StyleID = @StyleID,
	@StyleSet = @StyleSet,
	@ColorPaletteID = @ColorPaletteID, 
	@CUser = @CUser,
	@CDate  = @CDate,
	@AllSizeClasses  = @AllSizeClasses,
	@SeasonYearID  = @SeasonYearID,
	@ChangeTransID  = @ChangeTransID, 
	@ChangeTransUserID = @ChangeTransUserID,
	@ChangeTransPageName  = @ChangeTransPageName

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01617'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01617', GetDate())
END	

GO


