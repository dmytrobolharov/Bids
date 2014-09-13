/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderActivity_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderActivity_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolderActivity_INSERT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ColorFolderActivity_INSERT]
	(@ColorFolderId varchar(40),
	@ColorPaletteId varchar(40),
	@TeamId uniqueidentifier,
	@TradePartner varchar(1),
	@CreatedBy nvarchar(200),
	@CreatedDate datetime,
	@ColorActivity nvarchar(2),
	@ColorActivityDetail nvarchar(4000),
	@TimeInterval int)
AS 

DECLARE @ColorActivityDescription nvarchar(4000)
BEGIN
	SET @ColorActivityDescription = @ColorActivityDetail
END	
	
IF @ColorPaletteId = ''
		BEGIN
			DELETE FROM pColorFolderActivity WHERE CDATE >= (SELECT CONVERT(datetime,GETDATE(),101) - LEFT(CONVERT(VARCHAR, DATEADD(minute, @TimeInterval, 0), 108), 5)) AND 
			TeamId = @TeamId AND ColorFolderID = @ColorFolderID AND ActivityType = @ColorActivity AND ColorPaletteID IS NULL
			INSERT INTO pColorFolderActivity
			   ([ColorFolderActivityID]
			   ,[ColorFolderID]
			   ,[TeamID]
			   ,[TradePartner]
			   ,[CDate]
			   ,[CUser]
			   ,[ColorActivity]
			   ,[ActivityType])
			VALUES
			   (newid()
			   ,@ColorFolderID
			   ,@TeamID
			   ,@TradePartner
			   ,@CreatedDate
			   ,@CreatedBy
			   ,@ColorActivityDescription
			   ,@ColorActivity)		
		END	 
ELSE
		BEGIN
			DELETE FROM pColorFolderActivity WHERE CDATE >= (SELECT CONVERT(datetime,GETDATE(),101) - LEFT(CONVERT(VARCHAR, DATEADD(minute, @TimeInterval, 0), 108), 5)) AND 
			TeamId = @TeamId AND ColorFolderID = @ColorFolderID AND ActivityType = @ColorActivity AND ColorPaletteID = @ColorPaletteID
			INSERT INTO pColorFolderActivity
			   ([ColorFolderActivityID]
			   ,[ColorFolderID]
			   ,[ColorPaletteID]
			   ,[TeamID]
			   ,[TradePartner]
			   ,[CDate]
			   ,[CUser]
			   ,[ColorActivity]
			   ,[ActivityType])
			VALUES
			   (newid()
			   ,@ColorFolderID
			   ,@ColorPaletteID
			   ,@TeamID
			   ,@TradePartner
			   ,@CreatedDate
			   ,@CreatedBy
			   ,@ColorActivityDescription
			   ,@ColorActivity)		
		END

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03478', GetDate())

GO