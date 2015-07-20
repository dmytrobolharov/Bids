IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitItem_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_SampleRequestSubmitItem_SEL]
GO


CREATE VIEW [dbo].[vwx_SampleRequestSubmitItem_SEL]
AS

	SELECT a.* , b.Status AS StatusName
	FROM pSampleRequestSubmit a
	INNER JOIN pSampleRequestSubmitStatus b  ON a.Status =  b.StatusID
	
	





GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '782', GetDate())
GO
