@description('The name of the application which kv is creating for , value passing from the github actions workflow file.')
param appName string

@description('The target environment for this key vault.')
param environment string

@description('Azure region used for the deployment of all resources.')
param keyVaultLocation string

@description('Azure AD Tenant which existing  the User who executing resources deployment.')
param tenantId string

@description('enable Azure RBAC to provide better control at the individual secret/certificate/key level.')
param enableRbacAuthorization bool 

param softDeleteRetentionInDays int
param enableSoftDelete bool
param enablePurgeProtection bool

var unique = take(uniqueString(resourceGroup().id), 5)
var keyVaultName = toLower('kv-${appName}-${environment}-${unique}')

module keyVault './modules/keyvault.bicep' = {
  name: 'keyVault-deployment'
  params: {
    environment: environment
    keyVaultName: keyVaultName
    keyVaultLocation: keyVaultLocation
    tenantId: tenantId
    enableRbacAuthorization: enableRbacAuthorization
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
   // rbacRoleAssignments: rbacRoleAssignments
  }
}


output keyVaultResourceId string = keyVault.outputs.keyVaultId




