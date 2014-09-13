IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewSizeClassAndRange_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewSizeClassAndRange_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNewSizeClassAndRange_UPDATE] (
@StyleID UNIQUEIDENTIFIER, 
@NewStyleID UNIQUEIDENTIFIER 

)
AS

	DECLARE @SizeRange NVARCHAR(200), @SizeClass NVARCHAR(200)
	SELECT @SizeClass = SizeClass, @SizeRange = SizeRange FROM pStyleHeader WHERE StyleID = @StyleId		

	BEGIN
		UPDATE pStyleHeader SET SizeClass = @SizeClass, SizeRange = @SizeRange WHERE StyleID = @NewStyleID
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03692', GetDate())
GO