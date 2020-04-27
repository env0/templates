# Getting The Azure credentials
- You must have the Azure CLI setup
## Steps
1. Login - `az login`
2. Get the subscription ID - `az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"`
3. Set the subscription ID - `az account set --subscription="${SUBSCRIPTION_ID}"`
4. Create service principal - `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"`
5. From the service principal response - fill in these env vars
```
ARM_SUBSCRIPTION_ID={subscription id}
ARM_CLIENT_ID={service prinical appId}
ARM_CLIENT_SECRET={service principal password}
ARM_TENANT_ID={service principal tenant}
```
