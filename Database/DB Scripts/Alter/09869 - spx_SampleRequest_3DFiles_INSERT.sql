IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_3DFiles_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_3DFiles_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_3DFiles_INSERT]
(
	@SampleRequest3DFileID UNIQUEIDENTIFIER
	, @SampleRequestSubmitID UNIQUEIDENTIFIER
	, @SampleRequest3DFileName NVARCHAR(500)
	, @SampleRequest3DFileExt nVARCHAR(5)
	, @SampleRequest3DFileDescription NVARCHAR(4000)
	, @SampleRequest3DFileShared INT
	, @SampleRequest3DFileSize nVARCHAR(20)
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
)
AS
BEGIN 

	INSERT INTO pSampleRequest3DFiles(SampleRequest3DFileID, SampleRequestSubmitID, SampleRequest3DFileName, SampleRequest3DFileDescription
		, SampleRequest3DFileExt, SampleRequest3DFileSize, SampleRequest3DFileShared, CUser, CDate, MUser, MDate)
	VALUES (@SampleRequest3DFileID, @SampleRequestSubmitID, @SampleRequest3DFileName, @SampleRequest3DFileDescription
		, @SampleRequest3DFileExt, @SampleRequest3DFileSize, @SampleRequest3DFileShared, @CUser, @CDate, @CUser, @CDate)
		
END  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09869', GetDate())
GO