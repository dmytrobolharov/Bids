/****** Object:  StoredProcedure [dbo].[spx_BodyNewSizeClassAndRange_UPDATE]    Script Date: 04/11/2012 14:01:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BodyNewSizeClassAndRange_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BodyNewSizeClassAndRange_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BodyNewSizeClassAndRange_UPDATE]    Script Date: 04/11/2012 14:01:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_BodyNewSizeClassAndRange_UPDATE] 
(
@BodyID UNIQUEIDENTIFIER,  
@NewBodyID UNIQUEIDENTIFIER
) 
AS   

--DECLARE @SizeRange VARCHAR(200), @SizeClass VARCHAR(200) 
 
--SELECT @SizeClass = SizeClass, @SizeRange = SizeRange FROM pBody 
--WHERE BodyID = @BodyId  
   
--BEGIN   

--UPDATE pBody SET SizeClass = @SizeClass, SizeRange = @SizeRange WHERE BodyID = @NewBodyID  

--END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03335'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03335', GetDate())
END
GO