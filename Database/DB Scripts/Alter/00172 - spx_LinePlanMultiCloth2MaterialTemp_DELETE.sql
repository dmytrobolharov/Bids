-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 June 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_DELETE](
@LinePlanColorGroupID UNIQUEIDENTIFIER,
@LinePlanMaterialItemID UNIQUEIDENTIFIER,
@LinePlanRangeID UNIQUEIDENTIFIER,
@LinePlanID UNIQUEIDENTIFIER,
@MaterialID UNIQUEIDENTIFIER
)
AS


BEGIN
	DELETE FROM pLinePlanMultiCloth2MaterialTemp 
	WHERE LinePlanID = @LinePlanID 
		AND LinePlanMaterialItemID = @LinePlanMaterialItemID
		AND LinePlanColorGroupID = @LinePlanColorGroupID
		AND MaterialID = @MaterialID 
END	

BEGIN

	DELETE FROM pLinePlanMultiCloth2MaterialGroupItemTemp WHERE LinePlanColorGroupID = @LinePlanColorGroupID 
		AND LinePlanMultiCloth2ColorTempID IN (SELECT LinePlanMultiCloth2ColorTempID 
			FROM pLinePlanMultiCloth2ColorTemp WHERE LinePlanColorGroupID = @LinePlanColorGroupID 
				AND MaterialID = @MaterialID )
		
END	

BEGIN

	DELETE FROM pLinePlanMultiCloth2ColorTemp 
	WHERE LinePlanColorGroupID = @LinePlanColorGroupID 
		AND MaterialID = @MaterialID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '172', GetDate())
GO