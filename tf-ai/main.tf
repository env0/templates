
resource "helm_release" "heml" {
  name = "my-helm-release"
  values = [
    <<EOF
image
repository: nginx
tag: 1.16.0
pullPolicy: IfNotPresent
EOF
  ]
  chart = "./myetc.tar.gz"
}


# {
#   file: "resource "nul_resource" "hello" {
#   provisioner "local-exec" {
#     command = "echo hello world"
#   }
# }"
#   error: │ Error: Failed to query available provider packages
# │ 
# │ Could not retrieve the list of available versions for provider hashicorpul: provider registry registry.terraform.io does not have a provider named
# │ registry.terraform.io/hashicorpul
# │ 
# │ All modules should specify their required_providers so that external consumers will get the correct providers when using a module. To see which modules are currently
# │ depending on hashicorpul, run the following command:
# │     terraform providers
# tfVersion: 1.4.5
# }
