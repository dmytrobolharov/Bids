IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DefaultSeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DefaultSeasonYear_SELECT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE spx_DefaultSeasonYear_SELECT
AS
SELECT SeasonYearID FROM dbo.pSeasonYear WHERE Season = '*NA' AND Year = '*NA'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01649', GetDate())
GO