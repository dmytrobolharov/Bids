IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleMeasAccumarkMap_Insert') 
DROP PROCEDURE spx_StyleMeasAccumarkMap_Insert
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasAccumarkMap_Insert]    Script Date: 02/24/2011 15:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleMeasAccumarkMap_Insert]

(	@AMLMeasHdrId uniqueidentifier,
	@SizeCol nvarchar(10),    
	@TextSizeCol nvarchar(10),
	@SizeDesc nvarchar(20),    
	@TextSizeDesc nvarchar(20)		
)

AS 

Insert into pAccumarkMeasMap(AMLMeasHdrId, SizeCol, SizeDesc, TextSizeCol, TextSizeDesc ) 
values (@AMLMeasHdrId, @SizeCol, @SizeDesc, @TextSizeCol, @TextSizeDesc)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01202', GetDate())


