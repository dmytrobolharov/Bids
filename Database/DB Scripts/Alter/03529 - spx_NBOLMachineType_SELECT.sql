IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLMachineType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLMachineType_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_NBOLMachineType_SELECT] 
	@MachineClassId as uniqueidentifier
AS 

SELECT MachineTypeID, MachineTypeCode, MachineTypeName 
FROM pNBOLMachineType 
WHERE MachineClassID = @MachineClassId AND Active = 1
ORDER BY Sort

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03529', GetDate())
GO