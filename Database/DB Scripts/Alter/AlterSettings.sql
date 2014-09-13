--
-- Enable/Disable application settings....
--
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

print 'Checking for stored procs....'
IF EXISTS (select * from sysobjects where id = object_id('spx_ZZZ_AlterSettings') and sysstat & 0xf = 4)
    drop procedure spx_ZZZ_AlterSettings
GO

print 'Creat spx_ZZZ_AlterSettings...'
GO

CREATE PROCEDURE [dbo].[spx_ZZZ_AlterSettings]  (
@configFile NVARCHAR(512),
@settingKey NVARCHAR(512),
@settingValue NVARCHAR(512) 
)
AS

update sAppsetting
set AppsettingValue = @settingValue
where AppsettingKey = @settingKey 
	and ConfigFileName = @configFile

GO

print 'Altering settings....'

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Edit and add to these
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
exec spx_ZZZ_AlterSettings 
				@configFile = 'server.config',
				@settingKey = 'CA39465E-0CBE-4D73-AFE2-9601660B6E0D',
				@settingValue = 'Scripted'				
GO

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Edit the above.
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

drop procedure spx_ZZZ_AlterSettings
GO
