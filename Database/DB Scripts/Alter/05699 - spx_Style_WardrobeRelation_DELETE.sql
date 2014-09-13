/****** Object:  StoredProcedure [dbo].[spx_Style_WardrobeRelation_DELETE]    Script Date: 05/20/2013 14:59:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_WardrobeRelation_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_WardrobeRelation_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_WardrobeRelation_DELETE]    Script Date: 05/20/2013 14:59:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Style_WardrobeRelation_DELETE] 

	@StyleID uniqueidentifier, 
	@StyleRelationID uniqueidentifier,
	@SeasonYearID uniqueidentifier
AS
BEGIN
	
	SET NOCOUNT ON;

   DELETE FROM  pStyleWardrobeRelation WHERE StyleID = @StyleID AND StyleRelationID = @StyleRelationID AND SeasonYearID = @SeasonYearID
   DELETE FROM  pStyleWardrobeRelation WHERE StyleID = @StyleRelationID AND StyleRelationID = @StyleID AND SeasonYearID = @SeasonYearID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05699', GetDate())
GO

