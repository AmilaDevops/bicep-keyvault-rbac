# Provide access to Key Vault keys, certificates, and secrets with an Azure role-based access control.
 Using Azure RBAC secret, key, and certificate permissions with Key Vault. The new Azure RBAC permission model for key vault provides alternative to the vault access policy permissions model.

So in this repository by using bicep templates I creates a key vault and managed identity, and a role assignment for the managed identity to access the key vault. I'm using existing role "Contributor" as the Role definition ID for the roleAssignment resource. 

Also principalId is the id of the managed-identoty (user-assigned) I create and this is sometimes referred to as the object ID as well. In the resource roleAssignment we have to define principalType property, which specifies whether the principal is a user, a group, or a service principal. Managed identities are a form of service principal.<br />


<br />

# Configure the GitHub Actions workflow pipeline to deploy resources into Azure
### Generate deployment credentials:    
Your GitHub Actions run under an identity. Use the az ad sp create-for-rbac command to create a service principal for the identity. Grant the service principal the contributor role for the resource group created in the previous session so that the GitHub action with the identity can create resources in this resource group. It is recommended that you grant minimum required access.
`az ad sp create-for-rbac --name {app-name} --role owner --scopes /subscriptions/{subscription-id} --json-auth`

### Configure the GitHub secrets
Do setting in your Guthub account in path - Settings > Secrets and variables > Actions > New repository secret and add the out put of above step while creating the sp. As such { "clientId": "<GUID>",  "clientSecret": "<GUID>", "subscriptionId": "<GUID>", "tenantId": "<GUID>" ... }  and save the Repository Secret name as "AZURE_CREDENTIALS"


<br />

###  Steps for manual deployment:
To  deploy the Bicep file maually without using github actions (locally) to a new resource group use azure cli command - `az deployment group create --resource-group exampleRG --template-file main.bicep`






