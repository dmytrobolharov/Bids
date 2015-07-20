
/****** Object:  View [dbo].[vwx_User_Preference_SELECT]    Script Date: 04/14/2014 16:08:18 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_User_Preference_SELECT]'))
DROP VIEW [dbo].[vwx_User_Preference_SELECT]
GO


/****** Object:  View [dbo].[vwx_User_Preference_SELECT]    Script Date: 04/14/2014 16:08:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_User_Preference_SELECT]
AS
SELECT     dbo.uUserPreference.UserPreferenceID, dbo.uUserPreferenceObject.UserPreferenceObjectName, dbo.uUserPreferenceObject.UserPreferencePage, 
                      dbo.uUserPreference.UserPreferenceKey, dbo.uUserPreference.UserPreferenceValue, TeamID
FROM         dbo.uUserPreference INNER JOIN
                      dbo.uUserPreferenceObject ON dbo.uUserPreferenceObject.UserPreferenceObectID = dbo.uUserPreference.UserPreferenceObjectID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07495', GetDate())
GO

