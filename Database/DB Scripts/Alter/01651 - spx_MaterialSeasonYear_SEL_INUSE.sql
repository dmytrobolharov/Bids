IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSeasonYear_SEL_INUSE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSeasonYear_SEL_INUSE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE spx_MaterialSeasonYear_SEL_INUSE
(
@ComponentTypeID INT,
@MaterialID UNIQUEIDENTIFIER,  
@SeasonYearID UNIQUEIDENTIFIER 
)
AS

IF (SELECT COUNTVAL = COUNT(*) FROM pMaterialSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID= @SeasonYearID) = 0 
BEGIN
 SELECT ISNULL(DefaultSeasonYear,0) FROM dbo.pComponentType WHERE ComponentTypeID= @ComponentTypeID  
END
ELSE
BEGIN
 RETURN 0
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01651', GetDate())
GO