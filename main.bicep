param resourceGroupName string = 'KvRg

@description('The target environment for this key vault.')
param environment string = 'dev'

@description('Azure region used for the deployment of all resources.')
param keyVaultLocation string = resourceGroup().location

@description('Azure AD Tenant which existing  the User who executing resources deployment.')
param tenantId string = '8d670cc5-4448-409a-8c12-0d6f237d0da0'

@description('Object ID used for the User who executing resources deployment, can be a user, group or managed-identity')
param principalId string 

@description('enable Azure RBAC to provide better control at the individual secret/certificate/key level.')
param enableRbacAuthorization bool = true

param softDeleteRetentionInDays int = 30
param enableSoftDelete bool = true
param enablePurgeProtection bool = true

var unique = take(uniqueString(resourceGroup().id), 5)
var keyVaultName = toLower('kv-${keyVaultLocation}-${environment}-${unique}')

module keyVault './modules/keyvault.bicep' = {
  name: 'keyVault-deployment'
  params: {
    environment: environment
    keyVaultName: keyVaultName
    keyVaultLocation: keyVaultLocation
    tenantId: tenantId
    //principalId: principalId
    enableRbacAuthorization: enableRbacAuthorization
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
   // rbacRoleAssignments: rbacRoleAssignments
  }
}

output keyVaultResourceId string = keyVault.outputs.keyVaultId
