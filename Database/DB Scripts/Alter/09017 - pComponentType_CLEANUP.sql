-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 29 August 2014                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

--Lasts
UPDATE pComponentType
SET ComponentTypeRepId = '52CF6441-B4AB-4AE5-95A7-EDAA70F49E05'
WHERE ComponentDescription = 'Lasts'

--Leather
UPDATE pComponentType
SET ComponentTypeRepId = '169162E5-C8AF-4557-9FBA-C4CA46374A23'
WHERE ComponentDescription = 'Leather'

--Upper
UPDATE pComponentType
SET ComponentTypeRepId = 'B0ECE8EC-94F3-43D0-BD1F-93A5A040D816'
WHERE ComponentDescription = 'Upper'

--Toe Box
UPDATE pComponentType
SET ComponentTypeRepId = '406EB529-EC3A-4A0B-9AFD-5ECC7C1CFF60'
WHERE ComponentDescription = 'Toe Box'

--Heel
UPDATE pComponentType
SET ComponentTypeRepId = 'E6B6C996-62E2-4C80-9AD5-486847956FFE'
WHERE ComponentDescription = 'Heel'

--Sole
UPDATE pComponentType
SET ComponentTypeRepId = '6739C6C1-B40D-460D-8005-6A7B816FCBFD'
WHERE ComponentDescription = 'Sole'

--Tooling
UPDATE pComponentType
SET ComponentTypeRepId = 'C5EB9522-A038-4BB1-BB09-2F4876DE0229'
WHERE ComponentDescription = 'Tooling'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '6.0.0000', '09017', GetDate())
GO

SET NOCOUNT Off
GO
