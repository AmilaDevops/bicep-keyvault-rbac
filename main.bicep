@description('The name of the application which kv is creating for , value passing from the github actions workflow file.')
param appName string

@description('The target environment for this key vault.')
param environment string = 'dev'

@description('Azure region used for the deployment of all resources.')
param keyVaultLocation string = resourceGroup().location

@description('Azure AD Tenant which existing  the User who executing resources deployment.')
param tenantId string = '8d670cc5-4448-409a-8c12-0d6f237d0da0'

@description('enable Azure RBAC to provide better control at the individual secret/certificate/key level.')
param enableRbacAuthorization bool = true

param softDeleteRetentionInDays int = 90
param enableSoftDelete bool = true
param enablePurgeProtection bool = true

var unique = take(uniqueString(resourceGroup().id), 5)
var keyVaultName = toLower('kv-${appName}-${environment}-${unique}')

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

/*module mySecret 'services/keyvault-secret.bicep' = {
  name: 'deploy-kv-${name}-secret-mysecret'
  params: {
    keyVaultName: keyVault.outputs.name
    name: 'MySecret'
    value: mySecretValue
  }
}
*/

output keyVaultResourceId string = keyVault.outputs.keyVaultId




