IF OBJECT_ID(N'[dbo].[spx_POMTemplate_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_POMTemplate_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_POMTemplate_UPDATE]
(
@POMTempID uniqueidentifier,
@StyleID uniqueidentifier,
@SizeClass nvarchar(400),
@SizeRange nvarchar(200),
@MDate datetime,
@MUser nvarchar(200)
)
AS 


UPDATE  pPOMTemplate
SET     SizeRange = @SizeRange, SizeClass = @SizeClass, 
		MDate = @MDate, MUser = @MUser
WHERE  POMTempID = @POMTempID 

/*
DECLARE @tmpSizeClass nvarchar(50)
SELECT @tmpSizeClass = SizeClass FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID 

IF @tmpSizeClass = @SizeClass 
	BEGIN
		UPDATE  pStyleHeader
		SET SizeRange = @SizeRange, SizeClass = @SizeClass, MDate = @MDate, MUser = @MUser
		WHERE  StyleID = @StyleID 
	END
*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09675', GetDate())
GO