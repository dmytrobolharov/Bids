IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_3DFiles_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_3DFiles_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Style_3DFiles_INSERT]
(
	@Style3DFileID UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @SeasonYearID UNIQUEIDENTIFIER
	, @WorkflowItemID UNIQUEIDENTIFIER
	, @Style3DFileName NVARCHAR(500)
	, @Style3DFileExt nVARCHAR(5)
	, @Style3DFileDescription NVARCHAR(4000)
	, @Style3DFileShared INT
	, @Style3DFileSize nVARCHAR(20)
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
)
AS
BEGIN 

	INSERT INTO pStyle3DFiles(Style3DFileID, StyleID, WorkflowItemID, StyleSet, SeasonYearID, Style3DFileName
		, Style3DFileDescription, Style3DFileExt, Style3DFileSize, Style3DFileShared, CUser, CDate, MUser, MDate)
	VALUES (@Style3DFileID, @StyleID, @WorkflowItemID, @StyleSet, @SeasonYearID, @Style3DFileName
		, @Style3DFileDescription, @Style3DFileExt, @Style3DFileSize, @Style3DFileShared, @CUser, @CDate, @CUser, @CDate)
END  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09670', GetDate())
GO