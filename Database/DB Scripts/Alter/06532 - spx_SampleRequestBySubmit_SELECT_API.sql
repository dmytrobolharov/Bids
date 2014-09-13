/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBySubmit_SELECT_API]    Script Date: 11/06/2013 14:39:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBySubmit_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBySubmit_SELECT_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBySubmit_SELECT_API]    Script Date: 11/06/2013 14:39:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE  [dbo].[spx_SampleRequestBySubmit_SELECT_API](
	@SampleRequestSubmitID UNIQUEIDENTIFIER	
)
AS

SELECT * FROM (
SELECT SampleRequestSubmitID, SampleRequestTradeID
FROM pSampleRequestSubmit

UNION

SELECT SampleRequestSubmitID, SampleRequestTradeID
FROM pSampleRequestSubmitBOM) p 
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06532', GetDate())
GO