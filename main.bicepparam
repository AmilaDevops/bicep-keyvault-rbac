using './main.bicep'

param appName = 'tikiri'
param environment = 'dev'
param keyVaultLocation = 'eastus'
param tenantId = '8d670cc5-4448-409a-8c12-0d6f237d0da0'
param enableRbacAuthorization = true
param softDeleteRetentionInDays = 90
param enableSoftDelete = true
param enablePurgeProtection = true

