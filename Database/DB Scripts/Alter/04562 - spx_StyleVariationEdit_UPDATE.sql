/****** Object:  StoredProcedure [dbo].[spx_StyleVariationEdit_UPDATE]    Script Date: 12/05/2012 16:22:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariationEdit_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariationEdit_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleVariationEdit_UPDATE]    Script Date: 12/05/2012 16:22:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleVariationEdit_UPDATE]
(
@StyleDevelopmentID uniqueidentifier,
@VariationNo varchar(5),
@VariationName nvarchar(200),
@VariationSort int = NULL
)

AS 

/*
Created By Daniel @ 06/05/07 2:23 PM
*/
UPDATE pStyleDevelopmentItem
SET StyleDevelopmentName = @VariationName
WHERE (StyleDevelopmentID = @StyleDevelopmentID) AND (Variation = @VariationNo)

IF @VariationSort IS NOT NULL
BEGIN
	UPDATE pStyleDevelopmentItem
	SET Sort = @VariationSort
	WHERE (StyleDevelopmentID = @StyleDevelopmentID) AND (Variation = @VariationNo)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04562', GetDate())
GO
