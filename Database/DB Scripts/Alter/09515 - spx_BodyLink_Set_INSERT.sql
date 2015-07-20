IF OBJECT_ID(N'[dbo].[spx_BodyLink_Set_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodyLink_Set_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BodyLink_Set_INSERT](
@BodyID nvarchar(50),
@NewBodyID nvarchar(50),
@BodySet INT ,
@PomTempId nvarchar(50),
@CreatedBy nvarchar(200),
@BodySpecConversion nvarchar(10),
@CreatedDate datetime	
)
AS

SET NOCOUNT ON 

DECLARE @SizeRange nvarchar(200)
DECLARE @SizeClass nvarchar(400)
 
SELECT @SizeClass = SizeClass, @SizeRange = SizeRange FROM pPOMTemplate WHERE POMTempId = @POMTempId

SELECT * FROM pPOMTemplate WHERE POMTempId = @POMTempId

IF @BodySet = 1 
BEGIN 
	EXEC('spx_BodyHeaderLink_INSERT ''' + @BodyID + ''',''' + @NewBodyID + ''',''' + @SizeClass + ''',''' + @SizeRange + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	--EXEC('spx_BodyMaterialLink_INSERT ''' + @BodyID + ''',''' + @NewBodyID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	--EXEC('spx_BodyImageItemLink_INSERT ''' + @BodyID + ''',''' + @NewBodyID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	--EXEC('spx_BodyCareCopy_INSERT ''' + @BodyID + ''',''' + @NewBodyID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	--EXEC('spx_BodyCostingCopy_INSERT ''' + @BodyID + ''',''' + @NewBodyID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
END 

EXEC('spx_BodyDevelopmentSpecLinkSet_INSERT ''' + @BodyID + ''',''' + @NewBodyID + ''',''' + @SizeClass + ''',''' + @SizeRange + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''',''' + @BodySet + ''' ')
EXEC('spx_BodySpecSize_SELECT ''' + @NewBodyID + '''')


IF LOWER(@BodySpecConversion) = 'true'
BEGIN 
	EXEC('spx_BodySpecReconvert_UPDATE ''' +  @NewBodyID + ''',''' + @BodySet + ''' ')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09515', GetDate())
GO
