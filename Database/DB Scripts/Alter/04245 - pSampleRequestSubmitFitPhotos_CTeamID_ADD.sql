ALTER TABLE pSampleRequestSubmitFitPhotos ADD CTeamID uniqueidentifier NULL

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04245', GetDate())
GO
