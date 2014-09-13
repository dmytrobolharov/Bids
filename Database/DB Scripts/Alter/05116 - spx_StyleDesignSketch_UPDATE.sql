IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignSketch_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignSketch_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleDesignSketch_UPDATE](
	@StyleID uniqueidentifier,
	@DesignSketchVersion int,
	@DesignSketchID uniqueidentifier
)
AS 

UPDATE pStyleHeader 
SET DesignSketchID = @DesignSketchID,DesignSketchVersion = @DesignSketchVersion
WHERE StyleID = @StyleID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05116', GetDate())
GO
