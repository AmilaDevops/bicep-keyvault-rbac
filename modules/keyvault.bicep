param environment string
param keyVaultLocation string 
param tenantId string
param principalId string

param enableRbacAuthorization bool
param rbacRoleAssignments array
param keyVaultName string

param softDeleteRetentionInDays int
param enableSoftDelete bool
param enablePurgeProtection bool


resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: keyVaultLocation
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: enableRbacAuthorization
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
  }
}
