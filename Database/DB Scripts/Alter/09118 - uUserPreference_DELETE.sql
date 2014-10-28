/* as we no longer can hide columns on sku page in Line Plan
	 - make sure no column are still hidden by deleting them from user preferences */
DELETE up
FROM uUserPreference up
INNER JOIN uUserPreferenceObject upo ON up.UserPreferenceObjectID = upo.UserPreferenceObectID
WHERE upo.UserPreferencePage LIKE '%Planning_Folder_SKUPlan.aspx%'
	AND up.UserPreferenceKey = 'HiddenColumns'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09118', GetDate())
GO
