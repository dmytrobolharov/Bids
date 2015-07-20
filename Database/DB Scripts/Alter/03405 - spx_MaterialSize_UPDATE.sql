IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSize_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSize_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialSize_UPDATE]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialSize_UPDATE]
(
@MaterialSizeID uniqueidentifier,
@MaterialSize nvarchar(400),
@MaterialPrice decimal(19,2),
@MaterialSizeVersion int,
@MUser nvarchar(200),
@MDate datetime,
@Sort varchar(5)
)
AS 

BEGIN
	UPDATE pMaterialSize
	   SET 
		  MaterialSize = @MaterialSize, 
		  MaterialPrice = @MaterialPrice, 
		  MDate = @MDate, 
		  MUser = @MUser, 
		  MaterialSizeVersion = @MaterialSizeVersion, 
		  Sort = @Sort 
	 WHERE MaterialSizeID = @MaterialSizeID
END

GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03405', GetDate())
GO