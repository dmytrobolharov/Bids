IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMarker_UserSettings_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMarker_UserSettings_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMarker_UserSettings_Update]    Script Date: 03/09/2011 11:27:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleMarker_UserSettings_Update] (
@TeamId UNIQUEIDENTIFIER ,
@SetSection nvarchar(200),
@SetKey nvarchar(200)
)
AS


BEGIN


IF not exists  (select * from dbo.uUserSetting where TeamId = @TeamId and settingsection=@SetSection)
	begin
		INSERT INTO dbo.uUserSetting 
						(TeamId,settingsection,settingkey)
						VALUES 
					 (@TeamId,@SetSection,@SetKey)
	             
	end
else
	begin
		update dbo.uUserSetting set settingkey=@SetKey where TeamId=@TeamId and settingsection=@SetSection						
	             
	end
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01230', GetDate())
GO