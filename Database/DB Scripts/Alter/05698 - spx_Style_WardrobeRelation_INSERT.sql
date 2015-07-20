/****** Object:  StoredProcedure [dbo].[spx_Style_WardrobeRelation_INSERT]    Script Date: 05/20/2013 14:59:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_WardrobeRelation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_WardrobeRelation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_WardrobeRelation_INSERT]    Script Date: 05/20/2013 14:59:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Style_WardrobeRelation_INSERT] 

	@StyleID uniqueidentifier, 
	@StyleRelationID uniqueidentifier,
	@SeasonYearID uniqueidentifier
AS
BEGIN
	
	SET NOCOUNT ON;

   INSERT INTO pStyleWardrobeRelation(StyleID, StyleRelationID, SeasonYearID) values(@StyleID,@StyleRelationID, @SeasonYearID)
   INSERT INTO pStyleWardrobeRelation(StyleID, StyleRelationID, SeasonYearID) values(@StyleRelationID,@StyleID, @SeasonYearID)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05698', GetDate())
GO

