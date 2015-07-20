--
-- Daniel Pak 04-23-2010
--    Fix Style History not displaying in srmOn
--

ALTER  PROCEDURE spx_StyleHistory_SELECT
(@TeamId uniqueidentifier)
AS 

SELECT StyleId, StyleNo, [Description]
  FROM pStyleHeader WITH (NOLOCK) WHERE StyleId IN (SELECT StyleId FROM pStyleHistory WITH (NOLOCK) WHERE TeamID = @TeamID) 
ORDER BY [CDate] DESC
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '036', GetDate())
go
